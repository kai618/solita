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
  final GlobalKey<CardDrawingAreaState> drawKey = GlobalKey(); // for  card drawing area
  final List<GlobalKey<FlyableCardState>> cardKeys = List(52);

  @override
  void initState() {
    for (int i = 0; i < 7; i++) colKeys[i] = GlobalKey();
    for (int i = 0; i < 4; i++) suitKeys[i] = GlobalKey();
    for (int i = 0; i < 52; i++) cardKeys[i] = GlobalKey();

    handler.initDeck(cardKeys);
    handler.initAutoCardMovingHelper();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await handler.autoHelper?.keepMovingCard(flyCardToSuit);
    });
    super.initState();
  }

  void onCardsDraggedToColumn(int from, int to, List<DeckCard> cards) async {
    handler.onCardsAddedToColumn(cards, to, from);
    colKeys[to].currentState.onDragEnd();
    drawKey.currentState.reRender();
    await handler.autoHelper?.keepMovingCard(flyCardToSuit);
  }

  void onCardDraggedToSuit(int to, int from) {
    handler.onCardAddedToSuit(to, from);
    suitKeys[to].currentState.reRender();
    if (from == -1)
      drawKey.currentState.reRender();
    else
      colKeys[from].currentState.onDragEnd();
  }

  void onCardDrawn() async {
    await handler.autoHelper?.keepMovingCard(flyCardToSuit);
  }

  Future<void> flyCardToSuit(int from) async {
    final card = (from == -1) ? handler.deckOpened.last : handler.cardColumns[from].last;
    // wait for the flyable widget to build if its state is null
    while (card.key.currentState == null) await Future.delayed(Duration(milliseconds: 50));
    return await (card.key as GlobalKey<FlyableCardState>).currentState.flyToSuitDeck(
          onBefore: () {},
          onAfter: () {
            (from == -1) ? drawKey.currentState.reRender() : colKeys[from].currentState.onDragEnd();
            handler.onCardAddedToSuit(card.suit.index, from);
            suitKeys[card.suit.index].currentState.reRender();
          },
        );
  }

  void reset() async {
    setState(() {
      handler = RoundHandler();
    });
    handler.initDeck(cardKeys);
    handler.initAutoCardMovingHelper();
    for (int i = 0; i < colKeys.length; i++) colKeys[i].currentState.onDragEnd();
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
                      onCardDrawn: onCardDrawn,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(flex: 2, child: buildFinalSuitArea()),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            Expanded(flex: 12, child: buildCardColumnArea()),
            Expanded(flex: 2, child: buildButtons()),
          ],
        ),
      ),
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
          onCardAdded: onCardDraggedToSuit,
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
            onCardsAdded: onCardsDraggedToColumn,
          );
        },
      ).toList(),
    );
  }

  Widget buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(onPressed: this.reset, child: Text("Reset")),
        RaisedButton(onPressed: () => this.flyCardToSuit(6), child: Text("Fly")),
      ],
    );
  }
}
