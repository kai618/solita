import 'package:flutter/material.dart';
import 'package:solitaire/utils/card_rule.dart';
import 'package:solitaire/utils/constant.dart';
import 'package:solitaire/utils/deck_card.dart';

class ColumnDragTarget extends StatelessWidget {
  final int columnIndex; // index of the column
  final List<DeckCard> cards;
  final double dy; // the distance translated in y axis
  final Function onCardsAdded;
  final double height;

  ColumnDragTarget({
    @required this.columnIndex,
    @required this.cards,
    @required this.onCardsAdded,
    @required this.height,
    this.dy = Constant.dy,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, (cards.length - 1) * dy),
      child: DragTarget<Map>(
        onWillAccept: (data) => CardRule.isCardsAcceptedToColumn(cards, data["cards"]),
        onAccept: (data) => onCardsAdded(data["fromColumnIndex"], columnIndex, data["cards"]),
        builder: (context, dedicates, rejects) => Container(
          height: height,
          width: 40,
//          color: Colors.red.withOpacity(0.3),
        ),
      ),
    );
  }
}
