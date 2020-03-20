import 'package:flutter/material.dart';
import 'package:solitaire/utils/card_rule.dart';
import 'package:solitaire/widgets/card.dart' as sol;
import 'package:solitaire/widgets/ui_card.dart';

class CardColumn extends StatefulWidget {
  final List<sol.Card> cards;
  final Function onDraggedCardsAdded;
  final int columnIndex;

  CardColumn({this.cards, this.onDraggedCardsAdded, this.columnIndex});

  @override
  _CardColumnState createState() => _CardColumnState();
}

class _CardColumnState extends State<CardColumn> {
  @override
  Widget build(BuildContext context) {
    return DragTarget<Map>(
      builder: (context, dedicates, rejects) {
        return Stack(
          children: widget.cards.map((card) {
            int index = widget.cards.indexOf(card);
            return UICard();
          }).toList(),
        );
      },
      onWillAccept: (data) => CardRule.isDraggedCardsAccepted(widget.cards, data["draggedCards"]),
      onAccept: (data) {
        widget.onDraggedCardsAdded(data["draggedCards"], data["columnIndex"]);
      },
    );
  }
}
