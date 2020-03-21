import 'package:flutter/material.dart';
import 'package:solitaire/utils/round_handler.dart';
import 'package:solitaire/widgets/card_column.dart';
import 'package:solitaire/utils/deck_card.dart';

class PlayScreen extends StatefulWidget {
  static final screenName = "play_screen";

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final RoundHandler roundHandler = RoundHandler();

  @override
  void initState() {
    roundHandler.initDeck();
    roundHandler.cardColumns[5].forEach((card) => card.faceUp = true);
    super.initState();
  }

  void onCardAdded(int fromColumnIndex, int toColumnIndex, List<DeckCard> cards) {
    setState(() {
      roundHandler.cardColumns[toColumnIndex].addAll(cards);
      var oldColumn = roundHandler.cardColumns[fromColumnIndex];
      oldColumn.removeRange(oldColumn.length - cards.length, oldColumn.length);
      if (oldColumn.isNotEmpty) oldColumn.last.faceUp = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: roundHandler.cardColumns.map(
          (cards) {
            int index = roundHandler.cardColumns.indexOf(cards);
            return CardColumn(cards: cards, columnIndex: index, onCardsAdded: onCardAdded);
          },
        ).toList(),
      ),
    );
  }
}
