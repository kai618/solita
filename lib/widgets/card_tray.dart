import 'package:flutter/material.dart';
import 'package:solitaire/utils/constant.dart';

class CardTray extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constant.cardHeight,
      width: Constant.cardWidth,
      decoration: BoxDecoration(
        color: Colors.lime.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(Constant.cardRadius)),
      ),
    );
  }
}
