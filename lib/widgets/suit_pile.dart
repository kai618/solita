import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/utils/card_rule.dart';
import 'package:solitaire/utils/deck_card.dart';
import 'package:solitaire/utils/suit_global_position.dart';
import 'package:solitaire/widgets/card_tray.dart';
import 'package:solitaire/widgets/facing_up_card.dart';

class SuitPile extends StatefulWidget {
  final List<DeckCard> pile;
  final CardSuit suit;
  final Function onCardAdded;

  SuitPile({
    @required Key key,
    @required this.pile,
    @required this.suit,
    @required this.onCardAdded,
  }) : super(key: key);

  @override
  SuitPileState createState() => SuitPileState();
}

class SuitPileState extends State<SuitPile> {
  void reRender() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: (widget.pile.isEmpty) ? buildSymbolTray() : FacingUpCard(widget.pile.last),
          ),
          DragTarget<Map>(
            onWillAccept: (data) =>
                CardRule.isCardsAcceptedToSuit(widget.suit, widget.pile, data["cards"]),
            onAccept: (data) => widget.onCardAdded(widget.suit.index, data["fromColumnIndex"]),
            builder: (context, dedicates, rejects) => Container(
//                               color: Colors.red.withOpacity(0.3),
                height: 80,
                width: 50),
          ),
        ],
      ),
    );
  }

  Widget buildSymbolTray() {
    return CardTray(
      child: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final RenderBox box = context.findRenderObject();
            final position = box.localToGlobal(Offset.zero);
            Provider.of<SuitGlobalPosition>(context, listen: false).set(widget.suit, position);
          });

          return Center(
            child: Text(
              widget.suit.string,
              style: TextStyle(fontSize: 25, color: Colors.white.withOpacity(0.5)),
            ),
          );
        },
      ),
    );
  }
}
