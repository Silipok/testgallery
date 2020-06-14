

import 'package:flutter/material.dart';
import 'package:gallery_proj/model/picture.dart';
import 'package:gallery_proj/widgets/big_picture.dart';

class PictureCard extends StatelessWidget{
  final Picture picture;
  const PictureCard({this.picture});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => FullPicture(url: picture.imageLink['full'])));},
      child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Image.network(
              picture.imageLink['regular'], 
              fit: BoxFit.fitWidth,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
                }
              )
            ),
            Container(
            padding: EdgeInsets.all(1),
            child: 
              Text('Author: ${picture.author}', 
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto',
              ),
            )
          )
          ]
        ),
      )
    ])
    );
  }

}