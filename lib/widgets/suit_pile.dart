import 'package:flutter/material.dart';
import 'package:solitaire/utils/card_rule.dart';
import 'package:solitaire/utils/deck_card.dart';
import 'package:solitaire/widgets/card_tray.dart';
import 'package:solitaire/widgets/facing_up_card.dart';

class SuitPile extends StatelessWidget {
  final List<DeckCard> pile;
  final CardSuit suit;
  final Function onCardAdded;

  SuitPile({this.pile, this.suit, this.onCardAdded});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: (pile.isEmpty) ? CardTray() : FacingUpCard(pile.last),
          ),
          DragTarget<Map>(
            onWillAccept: (data) => CardRule.isCardsAcceptedToSuit(suit, pile, data["cards"]),
            onAccept: (data) => onCardAdded(suit, data["fromColumnIndex"]),
            builder: (context, dedicates, rejects) => Container(
              height: 80,
              width: 50,
//              color: Colors.red.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
