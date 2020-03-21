import 'package:flutter/material.dart';
import 'package:solitaire/utils/constant.dart';
import 'package:solitaire/utils/deck_card.dart';

class FacingUpCard extends StatelessWidget {
  final DeckCard card;

  FacingUpCard(this.card);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Constant.cardHeight,
        width: Constant.cardWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(Constant.cardRadius),
        ),
        child: Text(
          "${card.rank.string} ${card.suit.string}",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ));
  }
}
