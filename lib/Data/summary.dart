
import 'package:flutter_application_1/Data/card.dart';
import 'package:flutter_application_1/Data/collection.dart';

Future<Summary> fetchSummary() async {
  var collection = await fetchCollection();
  var cards = await fetchCards();
  return Summary();
}

class Summary {

}