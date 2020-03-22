import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solitaire/utils/constant.dart';
import 'package:solitaire/utils/deck_card.dart';
import 'package:solitaire/widgets/card_tray.dart';
import 'package:solitaire/widgets/draggable_card.dart';
import 'package:solitaire/widgets/column_drag_target.dart';
import 'package:solitaire/widgets/flyable_card.dart';

import 'facing_down_card.dart';

class CardColumn extends StatefulWidget {
  final List<DeckCard> cards;
  final Function onCardsAdded;
  final int columnIndex;

  CardColumn({
    Key key,
    @required this.cards,
    @required this.onCardsAdded,
    @required this.columnIndex,
  }) : super(key: key);

  @override
  CardColumnState createState() => CardColumnState();
}

class CardColumnState extends State<CardColumn> {
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

  void hideLastCard() {
    setState(() => lastVisibleCardIndex = widget.cards.length - 2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minHeight: (widget.cards.length - 1) * Constant.dy + Constant.cardHeight),
      child: Stack(children: <Widget>[
        CardTray(),
        ...buildDraggableCardPile(),
        buildTargetArea(),
      ]),
    );
  }

  List<Widget> buildDraggableCardPile() {
    return widget.cards.map((card) {
      int index = widget.cards.indexOf(card);
      return Transform.translate(
        offset: Offset(0, index * Constant.dy),
        child: card.faceUp
            ? FlyableCard(
                card: card,
                child: Visibility(
                  visible: index <= lastVisibleCardIndex,
                  child: DraggableCard(
                    card: card,
                    index: index,
                    columnIndex: widget.columnIndex,
                    attachedCards: widget.cards.sublist(index),
                    onDragStarted: onDragStarted,
                    onDragEnd: onDragEnd,
                  ),
                ),
              )
            : FacingDownCard(),
      );
    }).toList();
  }

  Widget buildTargetArea() {
    return ColumnDragTarget(
      cards: widget.cards,
      columnIndex: widget.columnIndex,
      onCardsAdded: widget.onCardsAdded,
    );
  }
}
