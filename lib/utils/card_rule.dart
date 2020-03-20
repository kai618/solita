import 'package:solitaire/widgets/card.dart';

class CardRule {
  static bool isDraggedCardsAccepted(List<Card> cardColumn, List<Card> draggedCards) {
    if (cardColumn.isEmpty) return true;

    // checking the color matching
    Card lastColumnCard = cardColumn.last;
    Card firstDraggedCard = draggedCards.first;
    if (lastColumnCard.color == firstDraggedCard.color) return false;

    // checking the rank order
    int lastColumnCardRankIndex = CardRank.values.indexOf(lastColumnCard.rank);
    int firstDraggedCardRankIndex = CardRank.values.indexOf(firstDraggedCard.rank);
    if (lastColumnCardRankIndex == firstDraggedCardRankIndex + 1) return true;
    return false;
  }
}
