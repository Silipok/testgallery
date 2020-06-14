
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'App.dart';
import 'bloc/gallery_bloc.dart';
import 'bloc/gallery_event.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<GalleryBloc>(
        create: (context) => GalleryBloc(httpClient: http.Client())..add(GalleryFetched()),
      ),
    ],
    child: GalleryApp(),
  ));
}
