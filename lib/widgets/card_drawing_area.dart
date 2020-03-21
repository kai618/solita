import 'package:flutter/material.dart';
import 'package:solitaire/utils/constant.dart';
import 'package:solitaire/utils/deck_card.dart';
import 'package:solitaire/widgets/card_tray.dart';
import 'package:solitaire/widgets/facing_down_card.dart';
import 'package:solitaire/widgets/facing_up_card.dart';

import 'draggable_card.dart';

class CardDrawingArea extends StatefulWidget {
  final List<DeckCard> deckClosed;
  final List<DeckCard> deckOpened;

  CardDrawingArea(this.deckClosed, this.deckOpened);

  @override
  _CardDrawingAreaState createState() => _CardDrawingAreaState();
}

class _CardDrawingAreaState extends State<CardDrawingArea> {
  void openCard() {
    setState(() {
      widget.deckOpened.add(widget.deckClosed.removeLast()..faceUp = true);
    });
  }

  void repeatCards() {
    setState(() {
      widget.deckOpened.reversed.forEach((card) => widget.deckClosed.add(card));
      widget.deckOpened.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Stack(
          children: <Widget>[
            GestureDetector(child: CardTray(), onTap: repeatCards),
            Visibility(
              visible: widget.deckClosed.isNotEmpty,
              child: GestureDetector(
                  child: Material(
                    elevation: 3,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(Constant.cardRadius),
                    child: FacingDownCard(),
                  ),
                  onTap: openCard),
            ),
          ],
        ),
        Container(
          height: Constant.cardHeight,
          child: Stack(
            children: <Widget>[
              CardTray(),
              widget.deckOpened.length > 1
                  ? FacingUpCard(widget.deckOpened[widget.deckOpened.length - 2])
                  : Container(),
              widget.deckOpened.isNotEmpty
                  ? DraggableCard(
                      card: widget.deckOpened.last,
                      attachedCards: [widget.deckOpened.last],
                      onDragStarted: (_) {},
                      onDragEnd: () {},
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
