// ignore_for_file: non_constant_identifier_names

import 'package:my_app/data/models/charachters.dart';
import 'package:my_app/data/models/quotes.dart';
import 'package:my_app/data/web_services/charachters_api.dart';

class CharactersRepository {
  final CharactersWebServices characterswebServices;

  CharactersRepository({
    required this.characterswebServices,
  });

  Future<List<Character>> getAllCharacters() async {
    final characters = await characterswebServices.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<Quote>> getCharacterQuotes(String charName) async {
    final quotes = await characterswebServices.getCharacterQuotes(charName);
    return quotes.map((charQuotes) => Quote.fromjson(charQuotes)).toList();
  }
}
