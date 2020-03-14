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

  List<Card> cardColumn1 = [];
  List<Card> cardColumn2 = [];
  List<Card> cardColumn3 = [];
  List<Card> cardColumn4 = [];
  List<Card> cardColumn5 = [];
  List<Card> cardColumn6 = [];
  List<Card> cardColumn7 = [];

  RoundHandler() {}

  void initDeck() {
    createAllCards();
    putRandomCardsToColumns();
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

    // col 1
    Card card = allCards.removeAt(ran.nextInt(allCards.length));
    cardColumn1.add(card);
    cardColumn1.last
      ..opened = true
      ..faceUp = true;

    // col 2
    for (int i = 0; i < 2; i++) {
      Card card = allCards.removeAt(ran.nextInt(allCards.length));
      cardColumn2.add(card);
    }
    cardColumn2.last
      ..opened = true
      ..faceUp = true;
  }
}
