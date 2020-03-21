import 'dart:math';

import 'package:solitaire/utils/deck_card.dart';

class RoundHandler {
  List<DeckCard> allCards = [];

  List<DeckCard> deckClosed = [];
  List<DeckCard> deckOpened = [];

  List<DeckCard> heartSuit = [];
  List<DeckCard> diamondSuit = [];
  List<DeckCard> spadeSuit = [];
  List<DeckCard> clubSuit = [];

  // 7 columns containing 28 random cards in total
  List<List<DeckCard>> cardColumns = List(7);

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
        allCards.add(DeckCard(suit: suit, rank: rank));
      });
    });
  }

  void putRandomCardsToColumns() {
    Random ran = Random();
    DeckCard card;

    for (int i = 0; i < 7; i++) {
      // 7 columns
      for (int j = 0; j <= i; j++) {
        // cards in each column
        card = allCards.removeAt(ran.nextInt(allCards.length));
        cardColumns[i].add(card);
      }
      // put the last card faced up
      cardColumns[i].last..faceUp = true;
    }
  }

  void putRemainingCardsToDeck() {
    deckClosed = allCards; // 24 remaining cards
    deckOpened.add(deckClosed.removeLast()..faceUp = true);
  }
}
