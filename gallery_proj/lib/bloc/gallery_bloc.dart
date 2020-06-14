import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gallery_proj/model/picture.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';


import 'gallery_event.dart';
import 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final http.Client httpClient;

  GalleryBloc({@required this.httpClient});

  @override
  get initialState => GalleryInitial();

  @override
  Stream<Transition<GalleryEvent, GalleryState>> transformEvents(
    Stream<GalleryEvent> events,
    TransitionFunction<GalleryEvent, GalleryState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<GalleryState> mapEventToState(GalleryEvent event) async* {
    final currentState = state;
    int page = 1;
    if (event is GalleryFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is GalleryInitial) {
          final gallery = await _fetchGallery(page);
          yield GallerySuccess(gallery: gallery, hasReachedMax: false);
          return;
        }
        if (currentState is GallerySuccess) {
          final gallery = await _fetchGallery(++page);
          yield gallery.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : GallerySuccess(
                  gallery: currentState.gallery + gallery,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield GalleryFailure();
      }
    }
  }

  bool _hasReachedMax(GalleryState state) =>
      state is GallerySuccess && state.hasReachedMax;

  Future<List<Picture>> _fetchGallery(int page) async {
    final response = await httpClient.get(
      'https://api.unsplash.com/photos/?page=$page&client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawPicture) {
        print(rawPicture['user']['username']);
        return Picture(
          id: rawPicture['id'],
          author: rawPicture['user']['username'],
          imageLink: rawPicture['urls'],
        );
      }).toList();
    } else {
      throw Exception('error fetching gallery');
    }
  }
}