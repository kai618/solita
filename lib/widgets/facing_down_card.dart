import 'package:flutter/material.dart';
import 'package:solitaire/utils/constant.dart';

class FacingDownCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constant.cardHeight,
      width: Constant.cardWidth,
      decoration: BoxDecoration(
        color: Colors.green[700],
        border: Border.all(color: Colors.black87,width: 0.7),
        borderRadius: BorderRadius.circular(Constant.cardRadius),
      ),
      child: Icon(Icons.spa, color: Colors.lightGreen[600],size: 33,),
    );
  }
}
