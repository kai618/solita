import 'package:flutter/material.dart';
import 'package:solitaire/utils/constant.dart';
import 'package:solitaire/utils/deck_card.dart';
import 'package:solitaire/widgets/facing_up_card.dart';
import 'package:solitaire/widgets/flyable_card.dart';
import 'package:solitaire/widgets/simple_card_column.dart';

class DraggableCard extends StatelessWidget {
  final int index; // index of the card in the column containing it
  final int columnIndex; // index of the column
  final DeckCard card; // card info
  final List<DeckCard> attachedCards; // cards below this card (inclusive)
  final Function onDragStarted;
  final Function onDragEnd;

  DraggableCard({
    this.index = 0,
    this.columnIndex = -1,
    this.card,
    this.attachedCards,
    this.onDragStarted,
    this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<Map>(
      maxSimultaneousDrags: 1,
      child: FacingUpCard(card),
      feedback: Material(
        elevation: 3,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(Constant.cardRadius),
        child: SimpleCardColumn(attachedCards),
      ),
      childWhenDragging: Container(),
      onDragStarted: () => onDragStarted(index),
      onDragEnd: (_) => onDragEnd(),
      data: {
        "cards": attachedCards,
        "fromColumnIndex": columnIndex,
      },
    );
  }
}
