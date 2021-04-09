import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_wars_wiki/core/models/character.dart';
import 'package:star_wars_wiki/core/utils/constants.dart';

class FavoritesRepository {
  Future<void> addFavorite(Character character) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> favorites = await getAll();

    favorites.add(character.name);

    await prefs.setStringList(Constants.favoritesPrefs, favorites);
  }

  Future<void> removeFavorite(Character character) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> favorites = await getAll();

    favorites.remove(character.name);

    await prefs.setStringList(Constants.favoritesPrefs, favorites);
  }

  Future<List<String>> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? favorites = prefs.getStringList(Constants.favoritesPrefs);

    return favorites ?? [];
  }
}
