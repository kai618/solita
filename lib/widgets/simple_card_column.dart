import 'package:flutter/material.dart';
import 'package:solitaire/widgets/facing_up_card.dart';
import 'package:solitaire/utils/deck_card.dart';

class SimpleCardColumn extends StatelessWidget {
  final List<DeckCard> cards;
  final double dy;

  SimpleCardColumn({this.cards, this.dy});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: cards.map((card) {
        int index = cards.indexOf(card);
        return Transform.translate(
          offset: Offset(0, index * dy),
          child: FacingUpCard(card),
        );
      }).toList(),
    );
  }
}
