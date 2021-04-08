import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_wiki/core/models/character.dart';
import 'package:star_wars_wiki/core/models/repositories/favorites_repository.dart';
import 'package:star_wars_wiki/core/models/sw_request.dart';
import 'package:star_wars_wiki/core/services/people_service.dart';
import 'package:star_wars_wiki/core/utils/constants.dart';
import 'package:star_wars_wiki/ui/utils/utils.dart';

class HomeModel extends ChangeNotifier {
  late final BuildContext context;

  SwRequest? _swRequest;

  bool _hasMore = true;
  bool _isLoading = false;
  bool _favoriteMode = false;
  List<String> _favorites = [];
  List<Character> _characters = [];

  bool get hasMore => _hasMore;

  bool get isLoading => _isLoading;

  bool get favoriteMode => _favoriteMode;

  SwRequest? get swRequest => _swRequest;

  List<String> get favorites => _favorites;

  List<Character> getCharacters() {
    return favoriteMode
        ? List.from(
            _characters.where(
              (char) => favorites.indexOf(char.name) != -1,
            ),
          )
        : _characters;
  }

  setHasMore(bool value) => _hasMore = value;
  setIsLoading(bool value) => _isLoading = value;

  setSwRequest(SwRequest value) {
    _swRequest = value;
    setHasMore(value.next != null);
    notifyListeners();
  }

  setFavoriteMode(bool value) {
    _favoriteMode = value;
    notifyListeners();
  }

  setFavorites(List<String> values) {
    _favorites = values;
    notifyListeners();
  }

  addCharacters(List<Character> values) {
    _characters.addAll(values);
    notifyListeners();
  }

  HomeModel() {
    this.getFavorites();
    this.getPerson();
  }

  void onFavoriteModeChanged() {
    setFavoriteMode(!favoriteMode);
  }

  Future<void> getPerson() async {
    try {
      if (favoriteMode || !hasMore) return;

      setIsLoading(true);

      int page = int.parse(swRequest?.next?.split("=").last ?? '1');

      SwRequest result = await PeopleService().getAll(page);

      addCharacters(result.characters);
      setSwRequest(result);
    } catch (e) {
      Utils.showBottomMessage(context, Constants.errorMessage);
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> getFavorites() async {
    List<String> favorites = await FavoritesRepository().getAllFavorites();
    setFavorites(favorites);
  }

  Future<void> onItemFavorite(Character character, bool favorite) async {
    try {
      if (favorite) {
        await _removeFavorite(character);
      } else {
        await _addFavorite(character);
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  Future<void> _addFavorite(Character character) async {
    try {
      await FavoritesRepository().addFavorite(character);

      List<String> newFavorites = List.from(favorites);

      newFavorites.add(character.name);

      setFavorites(newFavorites);
      Utils.showBottomMessage(context, Constants.successMessage);
    } catch (e) {
      Utils.showBottomMessage(context, Constants.errorMessage);
    }
  }

  Future<void> _removeFavorite(Character character) async {
    try {
      await FavoritesRepository().removeFavorite(character);

      List<String> newFavorites = List.from(favorites);

      newFavorites.remove(character.name);

      setFavorites(newFavorites);
      Utils.showBottomMessage(context, Constants.successMessage);
    } catch (e) {
      Utils.showBottomMessage(context, Constants.errorMessage);
    }
  }
}
