import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/utils/round_handler.dart';
import 'package:solitaire/utils/suit_global_position.dart';
import 'package:solitaire/widgets/card_column.dart';
import 'package:solitaire/utils/deck_card.dart';
import 'package:solitaire/widgets/card_drawing_area.dart';
import 'package:solitaire/widgets/flyable_card.dart';
import 'package:solitaire/widgets/suit_pile.dart';

class PlayScreen extends StatefulWidget {
  static final screenName = "play_screen";

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  RoundHandler handler = RoundHandler();
  final List<GlobalKey<CardColumnState>> colKeys = List(7);
  final List<GlobalKey<SuitPileState>> suitKeys = List(4);
  final GlobalKey<CardDrawingAreaState> drawKey = GlobalKey();
  final List<GlobalKey<FlyableCardState>> cardKeys = List(52);

  @override
  void initState() {
    for (int i = 0; i < 7; i++) colKeys[i] = GlobalKey();
    for (int i = 0; i < 4; i++) suitKeys[i] = GlobalKey();
    for (int i = 0; i < 52; i++) cardKeys[i] = GlobalKey();

    handler.initDeck(cardKeys);
    super.initState();
  }

  void onCardsAddedToColumn(int from, int to, List<DeckCard> cards) {
    handler.onCardsAddedToColumn(cards, to, from);
    colKeys[to].currentState.onDragEnd();
    drawKey.currentState.setState(() {});
  }

  void onCardAddedToSuit(int to, int from) {
    handler.onCardAddedToSuit(to, from);
    suitKeys[to].currentState.reRender();
    if (from == -1)
      drawKey.currentState.setState(() {});
    else
      colKeys[from].currentState.setState(() {});
  }

  void reset() {
    int colIndex = 6;
    final card = handler.cardColumns[colIndex].last;

    (card.key as GlobalKey<FlyableCardState>).currentState.flyToSuitDeck(onBefore: () {
      colKeys[colIndex].currentState.hideLastCard();
    }, onAfter: () {
      colKeys[colIndex].currentState.onDragEnd();
      handler.onCardAddedToSuit(card.suit.index, colIndex);
      suitKeys[card.suit.index].currentState.setState(() {});
    });
//    setState(() {
//      handler = RoundHandler();
//      handler.initDeck(cardKeys);
//      colKeys.forEach((key) => key.currentState.onDragEnd());
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ChangeNotifierProvider(
        create: (_) => SuitGlobalPosition(),
        child: Column(
          children: <Widget>[
            Expanded(flex: 2, child: Container()),
            Expanded(
              flex: 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: CardDrawingArea(
                      key: drawKey,
                      deckClosed: handler.deckClosed,
                      deckOpened: handler.deckOpened,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(flex: 2, child: buildFinalSuitArea()),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            Expanded(flex: 14, child: buildCardColumnArea()),
          ],
        ),
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
          key: suitKeys[index],
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
            key: colKeys[index],
            cards: cards,
            columnIndex: index,
            onCardsAdded: onCardsAddedToColumn,
          );
        },
      ).toList(),
    );
  }
}
