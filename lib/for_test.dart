import 'dart:convert';

void main() {
  String jsonString = '''
[
  {
    "artist": "Edgar Hidalgo",
    "attack": 4,
    "cardClass": "NEUTRAL",
    "collectible": true,
    "cost": 4,
    "dbfId": 90749,
    "elite": true,
    "flavor": "This next band features the one and only M.C. Tech on the drums, the fungal king of the keyboard Loatheb, and the showstopping vocal chops of Spellbreaker!",
    "hasDiamondSkin": true,
    "health": 4,
    "howToEarn": "Earnable after opening a <i>Festival of Legends</i> card pack.",
    "howToEarnGolden": "Earnable after purchasing the <i>Festival of Legends</i> Tavern Pass.",
    "id": "ETC_080",
    "mechanics": [
        "BATTLECRY",
        "DISCOVER"
    ],
    "name": "E.T.C., Band Manager",
    "rarity": "LEGENDARY",
    "set": "BATTLE_OF_THE_BANDS",
    "text": "[x]While building your deck,assemble a band of 3 cards.<b>Battlecry: Discover</b> one!",
    "type": "MINION"
  }
]
''';

var json = jsonDecode(jsonString) as List<dynamic>;
var data = CardsData.fromJson(json);
print(data);
}



class CardsData {
  final List<CardEntry> cards;

  CardsData({required this.cards});

  factory CardsData.fromJson(List<dynamic> json) {
    List<CardEntry> parsedCards = [];

    for (var value in json) {
      if (value['dbfId'] != null && value['set'] != null && value['rarity'] != null){
        var normalCollectible = value['howToEarn'] == null;
        var goldenCollectible = value['howToEarnGolden'] == null;
        var entry = CardEntry(
          dbfId: value['dbfId'],
          set: value['set'],
          rarity: value['rarity'],
          normalCollectible: normalCollectible,
          goldenCollectible: goldenCollectible
        );
        parsedCards.add(entry);
      }
    }

    return CardsData(cards: parsedCards);
  }
}

class CardEntry{
  final int dbfId;
  final String set;
  final String rarity;
  final bool normalCollectible;
  final bool goldenCollectible;

  CardEntry({required this.dbfId, required this.set, required this.rarity, required this.normalCollectible, required this.goldenCollectible});
}
  
  