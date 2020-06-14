

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'gallery_screen.dart';

class SplashScreen extends StatefulWidget{

  @override
  _SplashScreenState createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {
  _SplashScreenState();

  @override
  void initState(){
    super.initState();

    Timer(
      Duration(seconds: 5),() {
        Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryScreen()));
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold( 
      body: Center(child: Image.asset('images/unsplash-800x600.jpeg')),
      backgroundColor: Colors.black,
    );
  }
}