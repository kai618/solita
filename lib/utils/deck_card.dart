import 'package:flutter/foundation.dart';

class DeckCard {
  CardSuit suit;
  CardRank rank;
  Key key;
  bool faceUp;

  DeckCard({
    @required this.suit,
    @required this.rank,
    @required this.key,
    this.faceUp = false,
  });

  CardColor get color =>
      (suit == CardSuit.hearts || suit == CardSuit.diamonds) ? CardColor.red : CardColor.black;

  @override
  String toString() => "suit:${suit.string} rank:${rank.string} up:$faceUp";
}

enum CardSuit { hearts, diamonds, spades, clubs }

extension CardSuitMethod on CardSuit {
  String get string {
    switch (this) {
      case CardSuit.spades:
        return "\u2660";
      case CardSuit.hearts:
        return "\u2665";
      case CardSuit.diamonds:
        return "\u2666";
      case CardSuit.clubs:
        return "\u2663";
      default:
        return "error";
    }
  }

  int get index => CardSuit.values.indexOf(this);
}

enum CardRank { ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king }

extension CardRankMethod on CardRank {
  String get string {
    switch (this) {
      case CardRank.ace:
        return "A";
      case CardRank.two:
        return "2";
      case CardRank.three:
        return "3";
      case CardRank.four:
        return "4";
      case CardRank.five:
        return "5";
      case CardRank.six:
        return "6";
      case CardRank.seven:
        return "7";
      case CardRank.eight:
        return "8";
      case CardRank.nine:
        return "9";
      case CardRank.ten:
        return "10";
      case CardRank.jack:
        return "J";
      case CardRank.queen:
        return "Q";
      case CardRank.king:
        return "K";
      default:
        return "Joker";
    }
  }

  int get index => CardRank.values.indexOf(this);
}

enum CardColor { red, black }
