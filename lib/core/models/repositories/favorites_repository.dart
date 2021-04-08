import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_wars_wiki/core/models/character.dart';

class FavoritesRepository {
  Future<void> addFavorite(Character character) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> favorites = await getAllFavorites();

    favorites.add(character.name);

    await prefs.setStringList('favorites', favorites);
  }

  Future<void> removeFavorite(Character character) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> favorites = await getAllFavorites();

    favorites.remove(character.name);

    await prefs.setStringList('favorites', favorites);
  }

  Future<List<String>> getAllFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? favorites = prefs.getStringList('favorites');

    return favorites ?? [];
  }
}
