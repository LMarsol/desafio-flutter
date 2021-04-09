import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_wars_wiki/core/models/character.dart';

class CharactersRepository {
  Future<List<Character>> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? jsonData = prefs.getStringList('characters');

    if (jsonData == null) {
      return [];
    }

    List<Character> characters = jsonData
        .map(
          (e) => Character.fromJson(e),
        )
        .toList();

    return characters;
  }

  Future<void> saveCharacters(List<Character> characters) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? jsonData = prefs.getStringList('characters');

    if (jsonData == null) jsonData = [];

    List<Character> charsRepo = jsonData
        .map(
          (char) => Character.fromJson(char),
        )
        .toList();

    characters.forEach((char) {
      if (!charsRepo.contains(char)) {
        jsonData?.add(char.toJson());
      }
    });

    prefs.setStringList('characters', jsonData);
  }
}
