import 'package:flutter/material.dart';
import 'package:solitaire/utils/deck_card.dart';

class SuitGlobalPosition with ChangeNotifier {
  List<Offset> _values = [Offset.zero, Offset.zero, Offset.zero, Offset.zero];

  Offset get(CardSuit suit) => _values[suit.index];

  void set(CardSuit suit, Offset value) {
    _values[suit.index] = value;
    notifyListeners();
  }
}
