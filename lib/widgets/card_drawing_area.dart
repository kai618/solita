import 'package:flutter/material.dart';
import 'package:solitaire/utils/constant.dart';
import 'package:solitaire/utils/deck_card.dart';
import 'package:solitaire/widgets/card_tray.dart';
import 'package:solitaire/widgets/facing_down_card.dart';
import 'package:solitaire/widgets/facing_up_card.dart';
import 'package:solitaire/widgets/flyable_card.dart';

import 'draggable_card.dart';

class CardDrawingArea extends StatefulWidget {
  final List<DeckCard> deckClosed;
  final List<DeckCard> deckOpened;
  final Function onCardDrawn;

  const CardDrawingArea({
    @required Key key,
    @required this.deckClosed,
    @required this.deckOpened,
    @required this.onCardDrawn,
  }) : super(key: key);

  @override
  CardDrawingAreaState createState() => CardDrawingAreaState();
}

class CardDrawingAreaState extends State<CardDrawingArea> {
  void drawNewCard() {
    setState(() {
      widget.deckOpened.add(widget.deckClosed.removeLast()..faceUp = true);
//      Future.delayed(
//          const Duration(milliseconds: 50), widget.onCardDrawn); // needs time to build widget
      widget.onCardDrawn();
    });
  }

  void repeatCards() {
    setState(() {
      widget.deckOpened.reversed.forEach((card) => widget.deckClosed.add(card));
      widget.deckOpened.clear();
    });
  }

  void reRender() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final deckOpened = widget.deckOpened;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Stack(
          children: <Widget>[
            GestureDetector(
              child: CardTray(
                child: Icon(Icons.refresh, color: Colors.white70, size: 30),
              ),
              onTap: repeatCards,
            ),
            Visibility(
              visible: widget.deckClosed.isNotEmpty,
              child: GestureDetector(
                  child: Material(
                    elevation: 3,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(Constant.cardRadius),
                    child: FacingDownCard(),
                  ),
                  onTap: drawNewCard),
            ),
          ],
        ),
        Container(
          height: Constant.cardHeight,
          child: Stack(
            children: <Widget>[
              CardTray(),
              deckOpened.length > 1 ? FacingUpCard(deckOpened[deckOpened.length - 2]) : Container(),
              deckOpened.isNotEmpty
                  ? FlyableCard(
                      card: deckOpened.last,
                      child: DraggableCard(
                        card: deckOpened.last,
                        attachedCards: [deckOpened.last],
                        onDragStarted: (_) {},
                        onDragEnd: () {},
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
