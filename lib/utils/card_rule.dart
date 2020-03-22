import 'package:solitaire/utils/deck_card.dart';

class CardRule {
  static bool isCardsAcceptedToColumn(List<DeckCard> toColumn, List<DeckCard> fromCards) {
    if (toColumn.isEmpty) {
      if (fromCards.first.rank == CardRank.king) return true;
      return false;
    }

    // checking the color matching
    if (toColumn.last.color == fromCards.first.color) return false;

    // checking the rank order
    if (toColumn.last.rank.index == fromCards.first.rank.index + 1) return true;
    return false;
  }

  static bool isCardsAcceptedToSuit(
      CardSuit suit, List<DeckCard> toPile, List<DeckCard> fromCards) {
    if (fromCards.length == 1 && fromCards.first.suit == suit) {
      if (toPile.isEmpty) {
        if (fromCards.first.rank == CardRank.ace) return true;
        return false;
      } else if (fromCards.first.rank.index == toPile.last.rank.index + 1) return true;
    }
    return false;
  }
}
