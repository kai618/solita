import 'package:flutter/material.dart';
import 'package:solitaire/utils/constant.dart';
import 'package:solitaire/utils/deck_card.dart';

class FacingDownCard extends StatelessWidget {
  final DeckCard card;

  FacingDownCard(this.card);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constant.cardHeight,
      width: Constant.cardWidth,
      decoration: BoxDecoration(color: Colors.green, border: Border.all(color: Colors.black)),
    );
  }
}
