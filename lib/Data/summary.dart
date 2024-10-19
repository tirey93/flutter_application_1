
import 'package:flutter_application_1/Data/card.dart';
import 'package:flutter_application_1/Data/collection.dart';

Future<List<Summary>> fetchSummary() async {
  var collectionFuture = fetchCollection();
  var cardsFuture = fetchCards();
  late CollectionData collection;
  late CardsData cards;

  await Future.wait([
    collectionFuture.then((value) => collection = value),
    cardsFuture.then((value) => cards = value)
  ]);

  for (var entry in collection.collection) {
    var card = cards.cards[entry.cardId];
    if (card != null && entry.cardId == '102149'){
      int a = 5;
    }
  }
  int b = 4;
  return [
    Summary()
  ];
}

class Summary {
   final Map<String, Expansion> expansions = {
    "ISLAND_VACATION": Expansion("ISLAND_VACATION", 2024, 7),
    "WHIZBANGS_WORKSHOP": Expansion("WHIZBANGS_WORKSHOP", 2024, 3),
    "WILD_WEST": Expansion("WILD_WEST", 2023, 11),
    //...
    "WILD": Expansion("WILD", null, null),
   };
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
    "COMMON": Rarity("COMMON", 0),
    "RARE": Rarity("RARE", 1),
    "EPIC": Rarity("EPIC", 5),
    "LEGENDARY": Rarity("LEGENDARY", 20),
  };

}

class Rarity {
    final String id;
    final int cost;

    Map<String, int> qualities = {
    "regular": 0,
    "golden": 0,
    "diamond": 0,
    "signature": 0
  };

  Rarity(this.id, this.cost);
  void increment(String quailty) => qualities[quailty] = qualities[quailty]! + 1;


}

// class Quality {
//   final String rarity;
//   int regular = 0;
//   int golden = 0;

  

//   Quality(this.rarity);
  
// }