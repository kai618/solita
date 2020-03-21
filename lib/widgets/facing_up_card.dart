import 'package:flutter/material.dart';
import 'package:solitaire/utils/constant.dart';
import 'package:solitaire/utils/deck_card.dart';

class FacingUpCard extends StatelessWidget {
  final DeckCard card;

  FacingUpCard(this.card);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(3),
        height: Constant.cardHeight,
        width: Constant.cardWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 0.7),
          borderRadius: BorderRadius.circular(Constant.cardRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(card.rank.string, style: TextStyle(fontSize: 10)),
                const SizedBox(width: 2),
                Text(
                  card.suit.string,
                  style: TextStyle(
                    fontSize: 9,
                    color: (card.color == CardColor.black) ? Colors.black : Colors.red,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(card.rank.string, style: TextStyle(fontSize: 14)),
                const SizedBox(height: 2),
                Text(
                  card.suit.string,
                  style: TextStyle(
                    fontSize: 13,
                    color: (card.color == CardColor.black) ? Colors.black : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
