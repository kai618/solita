import 'package:solitaire/utils/card_rule.dart';
import 'package:solitaire/utils/deck_card.dart';

class AutoCardMovingHelper {
  final List<DeckCard> deckOpened;
  List<List<DeckCard>> columns;
  List<List<DeckCard>> suits;

  AutoCardMovingHelper({this.deckOpened, this.columns, this.suits});

  Future keepMovingCard(Function flyCardToSuit) async {
    var indexList = findSuitablePiles();
    while (indexList.isNotEmpty) {
      for (var index in indexList) await flyCardToSuit(index);
      indexList = findSuitablePiles();
      print(indexList);
    }
  }

  List<int> findSuitablePiles() {
    List<int> indexList = [];
    if (deckOpened.isNotEmpty) {
      DeckCard card = deckOpened.last;
      if (CardRule.isCardsAcceptedToSuit(card.suit, suits[card.suit.index], [card]))
        indexList.add(-1);
    }

    for (int i = 0; i < 7; i++) {
      if (columns[i].isEmpty) continue;
      DeckCard card = columns[i].last;
      if (CardRule.isCardsAcceptedToSuit(card.suit, suits[card.suit.index], [card]))
        indexList.add(i);
    }
    return indexList;
  }
}
