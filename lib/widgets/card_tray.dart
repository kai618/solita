import 'package:flutter/material.dart';
import 'package:solitaire/utils/constant.dart';

class CardTray extends StatelessWidget {
  final Widget child;

  const CardTray({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constant.cardHeight,
      width: Constant.cardWidth,
      decoration: BoxDecoration(
        color: Colors.green[100].withOpacity(0.6),
        borderRadius: BorderRadius.all(Radius.circular(Constant.cardRadius)),
      ),
      child: child,
    );
  }
}
