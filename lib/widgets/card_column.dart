import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solitaire/utils/constant.dart';
import 'package:solitaire/utils/deck_card.dart';
import 'package:solitaire/widgets/car_column_tray.dart';
import 'package:solitaire/widgets/draggable_card.dart';
import 'package:solitaire/widgets/drag_target_area.dart';

class CardColumn extends StatefulWidget {
  final List<DeckCard> cards;
  final Function onCardsAdded;
  final int columnIndex;

  CardColumn({this.cards, this.onCardsAdded, this.columnIndex});

  @override
  _CardColumnState createState() => _CardColumnState();
}

class _CardColumnState extends State<CardColumn> {
  int lastVisibleCardIndex;

  @override
  void initState() {
    lastVisibleCardIndex = widget.cards.length - 1;
    super.initState();
  }

  void onDragStarted(int index) {
    setState(() => lastVisibleCardIndex = index);
  }

  void onDragEnd() {
    setState(() => lastVisibleCardIndex = widget.cards.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    print("build card column");
    return Container(
      constraints:
          BoxConstraints(minHeight: (widget.cards.length - 1) * Constant.dy + Constant.cardHeight),
      child: Stack(children: <Widget>[
        CardColumnTray(),
        ...buildDraggableCardPile(),
        buildTargetArea(),
      ]),
    );
  }

  List<Widget> buildDraggableCardPile() {
    return widget.cards.map((card) {
      int index = widget.cards.indexOf(card);
      return DraggableCard(
        card: card,
        index: index,
        columnIndex: widget.columnIndex,
        attachedCards: widget.cards.sublist(index),
        visible: index <= lastVisibleCardIndex,
        onDragStarted: onDragStarted,
        onDragEnd: onDragEnd,
      );
    }).toList();
  }

  Widget buildTargetArea() {
    return DragTargetArea(
      cards: widget.cards,
      columnIndex: widget.columnIndex,
      onCardsAdded: widget.onCardsAdded,
      onDragEnd: onDragEnd,
    );
  }
}
