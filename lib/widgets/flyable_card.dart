import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/utils/constant.dart';
import 'package:solitaire/utils/deck_card.dart';
import 'package:solitaire/utils/suit_global_position.dart';
import 'package:solitaire/widgets/facing_up_card.dart';

class FlyableCard extends StatefulWidget {
  final DeckCard card;
  final Widget child;

  FlyableCard({
    @required this.card,
    @required this.child,
  }) : super(key: card.key);

  @override
  FlyableCardState createState() => FlyableCardState();
}

class FlyableCardState extends State<FlyableCard> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _anim;
  BuildContext _context;
  Offset _selfGlobalPosition;
  bool visible = true;
  final _duration = Duration(milliseconds: Constant.flyingTime);

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _duration);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future flyToSuitDeck({Function onBefore, Function onAfter}) async {
    OverlayState overlayState = Overlay.of(_context);
    OverlayEntry entry = OverlayEntry(
      builder: (context) => Stack(
        children: <Widget>[
          Container(color: Colors.transparent), // to prevent user from drag other cards
          Positioned(
            top: _selfGlobalPosition.dy,
            left: _selfGlobalPosition.dx,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => Transform.translate(offset: _anim.value, child: child),
              child: Material(
                elevation: 3,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(Constant.cardRadius),
                child: FacingUpCard(widget.card),
              ),
            ),
          ),
        ],
      ),
    );

    overlayState.insert(entry);
    setState(() => visible = false);
    onBefore();
    _controller.forward();

    return await Future.delayed(_duration, () {
      entry.remove();
      onAfter();
    });
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
    final suitGlobalPosition = Provider.of<SuitGlobalPosition>(context).get(widget.card.suit);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox box = context.findRenderObject();
      final suitLocalPosition = box.globalToLocal(suitGlobalPosition);
      _selfGlobalPosition = box.localToGlobal(Offset.zero);

      _anim = Tween(begin: Offset.zero, end: suitLocalPosition)
          .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad));
    });

    return Visibility(
      visible: visible,
      child: widget.child,
    );
  }
}