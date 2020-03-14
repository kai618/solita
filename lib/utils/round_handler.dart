import 'dart:math';

import 'package:solitaire/card.dart';

class RoundHandler {
  List<Card> allCards = [];

  List<Card> deckClosed = [];
  List<Card> deckOpened = [];

  List<Card> heartSuit = [];
  List<Card> diamondSuit = [];
  List<Card> spadeSuit = [];
  List<Card> clubSuit = [];

  // 7 columns containing 28 random cards in total
  List<List<Card>> cardColumns = List(7);

  RoundHandler() {
    for (int i = 0; i < 7; i++) cardColumns[i] = [];
  }

  void initDeck() {
    createAllCards();
    putRandomCardsToColumns();
    putRemainingCardsToDeck();
  }

  void createAllCards() {
    CardSuit.values.forEach((suit) {
      CardRank.values.forEach((rank) {
        allCards.add(Card(suit: suit, rank: rank));
      });
    });
  }

  void putRandomCardsToColumns() {
    Random ran = Random();
    Card card;

    for (int i = 0; i < 7; i++) {
      // 7 columns
      for (int j = 0; j <= i; j++) {
        // cards in each column
        card = allCards.removeAt(ran.nextInt(allCards.length));
        cardColumns[i].add(card);
      }
      cardColumns[i].last
        ..faceUp = true
        ..opened = true;
    }
  }

  void putRemainingCardsToDeck() {
    deckClosed = allCards; // 24 remaining cards
    deckOpened.add(deckClosed.removeLast()
      ..opened = true
      ..faceUp = true);
  }
}
