import 'dart:convert';
import 'package:http/http.dart' as http;

Future<CardsData> fetchCollection() async {
  final response = await http
      .get(Uri.parse('https://api.hearthstonejson.com/v1/latest/enUS/cards.json'));

  if (response.statusCode == 200) {
    var json = jsonDecode(response.body) as List<dynamic>;
    return CardsData.fromJson(json);
  } else {
    throw Exception('Failed to load album');
  }
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