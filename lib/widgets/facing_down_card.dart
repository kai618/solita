import 'package:flutter/material.dart';
import 'package:solitaire/utils/constant.dart';

class FacingDownCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constant.cardHeight,
      width: Constant.cardWidth,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(Constant.cardRadius),
      ),
    );
  }
}
