
import 'package:flutter_application_1/Data/card.dart';
import 'package:flutter_application_1/Data/collection.dart';

Future<Summary> fetchSummary() async {
  var collectionFuture = fetchCollection();
  var cardsFuture = fetchCards();
  late CollectionData collection;
  late CardsData cards;

  await Future.wait([
    collectionFuture.then((value) => collection = value),
    cardsFuture.then((value) => cards = value)
  ]);

  var summary = Summary();
  for (var entry in collection.collection) {
    var card = cards.cards[entry.cardId];
    if (card != null){
      if (summary.expansions.containsKey(card.set)){
        summary.increment(card.set, card.rarity, entry.qualities);
        int a = 5;
      }
      else{
        //wild case
      }
      int a = 5;
    }
  }
  int b = 4;
  return summary;
}

class Summary {
   final Map<String, Expansion> expansions = {
    "ISLAND_VACATION": Expansion("ISLAND_VACATION", 2024, 7),
    "WHIZBANGS_WORKSHOP": Expansion("WHIZBANGS_WORKSHOP", 2024, 3),
    "WILD_WEST": Expansion("WILD_WEST", 2023, 11),
    //...
    "WILD": Expansion("WILD", null, null),
   };

   void increment(String expansion, String rarity, Map<String, int> qualities)
    => expansions[expansion]!.rarities[rarity]!.increment(qualities);
}

//get expansion of the card based on card.set
//get Quality based on card.rarity
//increment quality 
class Expansion {
  final String name;
  int? releaseYear;
  int? releaseMonth;

  Expansion(this.name, this.releaseYear, this.releaseMonth);
  
  final Map<String, Rarity> rarities = {
    "COMMON": Rarity("COMMON", 0, 2),
    "RARE": Rarity("RARE", 1, 5),
    "EPIC": Rarity("EPIC", 5, 20),
    "LEGENDARY": Rarity("LEGENDARY", 20, 80),
  };

}

class Rarity {
    final String id;
    final int normalCost;
    final int premiumCost;

    Map<String, int> qualities = {
    "regular": 0,
    "golden": 0,
    "diamond": 0,
    "signature": 0
  };

  Rarity(this.id, this.normalCost, this.premiumCost);

  void increment(Map<String, int> qualities){
    for (var quality in qualities.entries) {
      this.qualities[quality.key] = this.qualities[quality.key]! + quality.value;
    }
  }
  int getNormalCost() => qualities['regular']! * normalCost;
  int getPremiumCost() => (qualities['golden']! + qualities['signature']!) * premiumCost;
}