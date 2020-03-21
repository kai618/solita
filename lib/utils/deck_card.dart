import 'package:flutter/material.dart';

enum CardSuit { spades, hearts, diamonds, clubs }

enum CardRank { ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king }

enum CardColor { red, black }

class DeckCard {
  CardSuit suit;
  CardRank rank;
  bool faceUp;

  DeckCard({
    @required this.suit,
    @required this.rank,
    this.faceUp = false,
  });

  CardColor get color {
    if (suit == CardSuit.hearts || suit == CardSuit.diamonds) {
      return CardColor.red;
    } else {
      return CardColor.black;
    }
  }

  String get suitName {
    switch (suit) {
      case CardSuit.spades:
        return "\u2660";
      case CardSuit.hearts:
        return "\u2665";
      case CardSuit.diamonds:
        return "\u2666";
      case CardSuit.clubs:
        return "\u2667";
      default:
        return "error";
    }
  }

  String get rankName {
    switch (rank) {
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

  @override
  String toString() => "suit:$suit rank:$rank up:$faceUp";
}
