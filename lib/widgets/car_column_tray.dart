import 'package:flutter/material.dart';
import 'package:solitaire/utils/constant.dart';

class CardColumnTray extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constant.cardHeight,
      width: Constant.cardWidth,
      decoration: BoxDecoration(
        color: Colors.lime,
        borderRadius: BorderRadius.all(Radius.circular(Constant.cardRadius)),
      ),
    );
  }
}
