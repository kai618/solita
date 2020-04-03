import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solitaire/utils/card_rule.dart';
import 'package:solitaire/utils/deck_card.dart';

class RoundHandler {
  List<DeckCard> allCards = [];

  List<DeckCard> deckClosed = [];
  List<DeckCard> deckOpened = [];

  // 7 columns containing 28 random cards in total
  List<List<DeckCard>> cardColumns = List(7);

  // 4 final suits
  List<List<DeckCard>> suitPiles = List(4);

  bool autoAllowed;

  RoundHandler() {
    for (int i = 0; i < 7; i++) cardColumns[i] = [];
    for (int i = 0; i < 4; i++) suitPiles[i] = [];

    autoAllowed = true; // get from settings
  }

  void initDeck(List<Key> cardKeys) {
    createAllCards(cardKeys);
    putRandomCardsToColumns();
    putRemainingCardsToDeckRandomly();
  }

  void createAllCards(List<Key> cardKeys) {
    int keyIndex = 0;
    CardSuit.values.forEach((suit) {
      CardRank.values.forEach((rank) {
        allCards.add(DeckCard(suit: suit, rank: rank, key: cardKeys[keyIndex++]));
      });
    });
  }

  void putRandomCardsToColumns() {
    final Random ran = Random();
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

  void putRemainingCardsToDeckRandomly() {
    final Random ran = Random();
    DeckCard card;

    while (allCards.length > 1) {
      card = allCards.removeAt(ran.nextInt(allCards.length));
      deckClosed.add(card);
    }
    deckClosed.add(allCards.removeLast());
  }

  void onCardsAddedToColumn(List<DeckCard> cards, int toIndex, [int fromIndex = -1]) {
    cardColumns[toIndex].addAll(cards);
    if (fromIndex != -1) {
      // cards from other columns
      var oldColumn = cardColumns[fromIndex];
      oldColumn.removeRange(oldColumn.length - cards.length, oldColumn.length);
      if (oldColumn.isNotEmpty) oldColumn.last.faceUp = true;
    } else {
      // card from drawing area
      deckOpened.removeLast();
    }
  }

  void onCardAddedToSuit(int to, int from) {
    if (from != -1) {
      // one card added from columns
      suitPiles[to].add(cardColumns[from].removeLast());
      if (cardColumns[from].isNotEmpty) cardColumns[from].last.faceUp = true;
    } else
      // one card added from drawing deck
      suitPiles[to].add(deckOpened.removeLast());
  }

  void stopAutoCardMovingHelper() {
    autoAllowed = false;
  }

  // code for auto card moving
  Future<void> keepMovingCard(Function flyCardToSuit) async {
    if (!autoAllowed) return;

    var toFromList = findSuitablePiles();
    print(toFromList);
    while (toFromList.isNotEmpty && autoAllowed) {
      for (var toFrom in toFromList) {
        await flyCardToSuit(toFrom["from"]);
        onCardAddedToSuit(toFrom["to"], toFrom["from"]);
      }
      toFromList = findSuitablePiles();
    }
  }

  List<Map<String, int>> findSuitablePiles() {
    List<Map<String, int>> toFromList = [];
    if (deckOpened.isNotEmpty) {
      DeckCard card = deckOpened.last;
      if (CardRule.isCardsAcceptedToSuit(card.suit, suitPiles[card.suit.index], [card]))
        toFromList.add({"to": card.suit.index, "from": -1});
    }

    for (int i = 0; i < 7; i++) {
      if (cardColumns[i].isEmpty) continue;
      DeckCard card = cardColumns[i].last;
      if (CardRule.isCardsAcceptedToSuit(card.suit, suitPiles[card.suit.index], [card]))
        toFromList.add({"to": card.suit.index, "from": i});
    }
    return toFromList;
  }
}
