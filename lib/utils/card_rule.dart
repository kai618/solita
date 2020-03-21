import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solitaire/utils/deck_card.dart';

class CardRule {
  static bool isCardsAcceptedToColumn(List<DeckCard> cardColumn, List<DeckCard> draggedCards) {
    DeckCard firstDraggedCard = draggedCards.first;
    if (cardColumn.isEmpty) {
      if (firstDraggedCard.rank == CardRank.king) return true;
      return false;
    }
    DeckCard lastColumnCard = cardColumn.last;

    // checking the color matching
    if (lastColumnCard.color == firstDraggedCard.color) return false;

    // checking the rank order
    int firstDraggedCardRankIndex = CardRank.values.indexOf(firstDraggedCard.rank);
    int lastColumnCardRankIndex = CardRank.values.indexOf(lastColumnCard.rank);
    if (lastColumnCardRankIndex == firstDraggedCardRankIndex + 1) return true;
    return false;
  }

  static bool isCardsAcceptedToSuit(
      CardSuit suit, List<DeckCard> toPile, List<DeckCard> fromCards) {
    if (fromCards.length == 1 && fromCards.first.suit == suit) {
      if (toPile.isEmpty) {
        if (fromCards.first.rank == CardRank.ace) return true;
        return false;
      } else {
        int pileRankIndex = CardRank.values.indexOf(toPile.last.rank);
        int cardRankIndex = CardRank.values.indexOf(fromCards.first.rank);
        if (cardRankIndex == pileRankIndex + 1) return true;
      }
    }
    return false;
  }
}
