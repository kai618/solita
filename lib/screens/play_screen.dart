import 'package:flutter/material.dart';
import 'package:solitaire/utils/round_handler.dart';
import 'package:solitaire/widgets/card_column.dart';
import 'package:solitaire/utils/deck_card.dart';
import 'package:solitaire/widgets/card_drawing_area.dart';
import 'package:solitaire/widgets/suit_pile.dart';

class PlayScreen extends StatefulWidget {
  static final screenName = "play_screen";

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  RoundHandler handler = RoundHandler();
  final List<GlobalKey<CardColumnState>> keys = List(7);

  @override
  void initState() {
    handler.initDeck();
    for (int i = 0; i < 7; i++) {
      keys[i] = GlobalKey();
    }
    super.initState();
  }

  void onCardsAddedToColumn(int from, int to, List<DeckCard> cards) {
    setState(() => handler.onCardsAddedToColumn(cards, to, from));
    keys[to].currentState.onDragEnd();
  }

  void onCardAddedToSuit(CardSuit suit, int from) {
    setState(() => handler.onCardAddedToSuit(suit, from));
    if (from != -1) keys[from].currentState.setState(() {});
  }

  void reset() {
    setState(() {
      handler = RoundHandler();
      handler.initDeck();
      keys.forEach((key) => key.currentState.onDragEnd());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: <Widget>[
          Expanded(flex: 2, child: Container()),
          Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(flex: 1, child: CardDrawingArea(handler.deckClosed, handler.deckOpened)),
                const SizedBox(width: 10),
                Expanded(flex: 2, child: buildFinalSuitArea()),
                const SizedBox(width: 10),
              ],
            ),
          ),
          Expanded(flex: 14, child: buildCardColumnArea()),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: reset, child: Icon(Icons.refresh)),
    );
  }

  Widget buildFinalSuitArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: handler.suitPiles.map((pile) {
        int index = handler.suitPiles.indexOf(pile);
        return SuitPile(
          pile: pile,
          suit: CardSuit.values[index],
          onCardAdded: onCardAddedToSuit,
        );
      }).toList(),
    );
  }

  Widget buildCardColumnArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: handler.cardColumns.map(
        (cards) {
          int index = handler.cardColumns.indexOf(cards);
          return CardColumn(
            key: keys[index],
            cards: cards,
            columnIndex: index,
            onCardsAdded: onCardsAddedToColumn,
          );
        },
      ).toList(),
    );
  }
}
