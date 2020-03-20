import 'package:flutter/material.dart';

enum CardSuit { spades, hearts, diamonds, clubs }

enum CardRank { ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king }

enum CardColor { red, black }

class Card {
  CardSuit suit;
  CardRank rank;
  bool faceUp;
  bool opened;

  Card({
    @required this.suit,
    @required this.rank,
    this.faceUp = false,
    this.opened = false,
  });

  CardColor get color {
    if (suit == CardSuit.hearts || suit == CardSuit.diamonds) {
      return CardColor.red;
    } else {
      return CardColor.black;
    }
  }

  @override
  String toString() => "suit:$suit rank:$rank up:$faceUp opened:$opened";
}
