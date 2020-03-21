import 'package:flutter/material.dart';
import 'package:solitaire/utils/round_handler.dart';
import 'package:solitaire/widgets/card_column.dart';
import 'package:solitaire/utils/deck_card.dart';
import 'package:solitaire/widgets/card_drawing_area.dart';

class PlayScreen extends StatefulWidget {
  static final screenName = "play_screen";

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final RoundHandler handler = RoundHandler();

  @override
  void initState() {
    handler.initDeck();
    super.initState();
  }

  void onCardsAddedToColumn(int from, int to, List<DeckCard> cards) {
    setState(() => handler.onCardsAddedToColumn(cards, to, from));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: CardDrawingArea(
                      deckClosed: handler.deckClosed,
                      deckOpened: handler.deckOpened,
                    )),
                Expanded(flex: 4, child: buildFinalSuitArea()),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: buildCardColumnArea(),
          ),
        ],
      ),
    );
  }

  Widget buildFinalSuitArea() {
    return Container(
      color: Colors.lightGreen,
    );
  }

  Widget buildCardColumnArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: handler.cardColumns.map(
        (cards) {
          int index = handler.cardColumns.indexOf(cards);
          return CardColumn(cards: cards, columnIndex: index, onCardsAdded: onCardsAddedToColumn);
        },
      ).toList(),
    );
  }
}
