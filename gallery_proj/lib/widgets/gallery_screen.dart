

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_proj/bloc/gallery_bloc.dart';
import 'package:gallery_proj/bloc/gallery_event.dart';
import 'package:gallery_proj/bloc/gallery_state.dart';
import 'package:gallery_proj/widgets/picture_card.dart';

class GalleryScreen extends StatefulWidget{
@override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  GalleryBloc _galleryBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _galleryBloc = BlocProvider.of<GalleryBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryBloc, GalleryState>(
      builder: (context, state) {
        if (state is GalleryFailure) {
          return Center(
            child: Text('failed to fetch posts'),
          );
        }
        if (state is GallerySuccess) {
          if (state.gallery.isEmpty) {
            return Center(
              child: Text('no picture'),
            );
          }
          return 
          Scaffold(
          backgroundColor: Colors.grey[100],
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 3.0,
                  childAspectRatio: MediaQuery.of(context).size.height / 600
                ),
            itemBuilder: (BuildContext context, int index) {
              return index >= state.gallery.length
                  ? CircularProgressIndicator()
                  : PictureCard(picture: state.gallery[index]);
            },
            itemCount: state.hasReachedMax
                ? state.gallery.length
                : state.gallery.length + 1,
            controller: _scrollController,
          )
        );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _galleryBloc.add(GalleryFetched());
    }
  }
}