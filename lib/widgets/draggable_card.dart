import 'package:flutter/material.dart';
import 'package:solitaire/utils/constant.dart';
import 'package:solitaire/utils/deck_card.dart';
import 'package:solitaire/widgets/facing_down_card.dart';
import 'package:solitaire/widgets/facing_up_card.dart';
import 'package:solitaire/widgets/simple_card_column.dart';

class DraggableCard extends StatelessWidget {
  final int index; // index of the card in the column containing it
  final int columnIndex; // index of the column
  final DeckCard card; // card info
  final double dy; // the distance translated in y axis
  final List<DeckCard> attachedCards; // cards below this card (inclusive)
  final bool visible;
  final Function onDragStarted;
  final Function onDragEnd;

  DraggableCard({
    this.index,
    this.columnIndex,
    this.card,
    this.dy = Constant.dy,
    this.attachedCards,
    this.visible,
    this.onDragStarted,
    this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Transform.translate(
        offset: Offset(0, index * dy),
        child: card.faceUp ? buildDraggableCard() : FacingDownCard(card),
      ),
    );
  }

  Widget buildDraggableCard() {
    return Draggable<Map>(
      child: FacingUpCard(card),
      feedback: Material(child: SimpleCardColumn(cards: attachedCards, dy: dy)),
      childWhenDragging: Container(),
      onDragStarted: () => onDragStarted(index),
      onDragEnd: (_) => onDragEnd(),
      data: {"cards": attachedCards, "fromColumnIndex": columnIndex},
    );
  }
}
