

import 'package:flutter/material.dart';
import 'package:gallery_proj/widgets/splash_screen.dart';

class GalleryApp extends StatelessWidget{

  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GalleryApp",
      home: Scaffold(
          backgroundColor: Colors.blue[100],
          body: SplashScreen()
        ),
    );
  }
}