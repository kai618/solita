import 'package:flutter/material.dart';
import 'package:solitaire/utils/constant.dart';
import 'package:solitaire/widgets/facing_up_card.dart';
import 'package:solitaire/utils/deck_card.dart';

class SimpleCardColumn extends StatelessWidget {
  final List<DeckCard> cards;

  SimpleCardColumn(this.cards);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5,
      borderRadius: BorderRadius.circular(Constant.cardRadius),
      child: Container(
        height: (cards.length - 1) * Constant.dy + Constant.cardHeight,
        child: Stack(
          children: cards.map((card) {
            int index = cards.indexOf(card);
            return Transform.translate(
              offset: Offset(0, index * Constant.dy),
              child: FacingUpCard(card),
            );
          }).toList(),
        ),
      ),
    );
  }
}
