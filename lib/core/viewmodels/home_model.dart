import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_wiki/core/models/character.dart';
import 'package:star_wars_wiki/core/models/sw_request.dart';
import 'package:star_wars_wiki/core/repositories/characters_repository.dart';
import 'package:star_wars_wiki/core/repositories/favorites_repository.dart';
import 'package:star_wars_wiki/core/services/favorites_service.dart';
import 'package:star_wars_wiki/core/services/people_service.dart';
import 'package:star_wars_wiki/core/utils/constants.dart';
import 'package:star_wars_wiki/core/utils/network_info.dart';
import 'package:star_wars_wiki/ui/utils/utils.dart';

class HomeModel extends ChangeNotifier {
  late final BuildContext context;

  HomeModel() {
    this.getCharacters();

    this._getFavorites();
    this._sendWaitingReqs();
  }

  SwRequest? _swRequest;

  String? _searchText;
  bool _hasMore = true;
  bool _isLoading = false;
  bool _searchMode = false;
  bool _favoriteMode = false;
  bool _hasConnection = true;
  List<String> _favorites = [];
  List<Character> _characters = [];

  String? get searchText => _searchText;

  bool get hasMore => _hasMore;

  bool get isLoading => _isLoading;

  bool get searchMode => _searchMode;

  bool get favoriteMode => _favoriteMode;

  bool get hasConnection => _hasConnection;

  SwRequest? get swRequest => _swRequest;

  List<String> get favorites => _favorites;

  List<Character> get characters => favoriteMode
      ? List.from(
          _characters.where(
            (char) => favorites.indexOf(char.name) != -1
                ? _searchText != null
                    ? char.name
                        .toLowerCase()
                        .contains(_searchText!.toLowerCase())
                    : true
                : false,
          ),
        )
      : List.from(
          _characters.where(
            (char) => _searchText != null
                ? char.name.toLowerCase().contains(_searchText!.toLowerCase())
                : true,
          ),
        );

  void setHasMore(bool value) {
    _hasMore = value;
  }

  void setIsLoading(bool value) {
    _isLoading = value;
  }

  void setSearchMode(bool value) {
    _searchMode = value;
    notifyListeners();
  }

  void setSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  void setHasConnection(bool value) {
    _hasConnection = value;
    notifyListeners();
  }

  void setSwRequest(SwRequest value) {
    _swRequest = value;
    setHasMore(value.next != null);
    notifyListeners();
  }

  void setFavoriteMode(bool value) {
    _favoriteMode = value;
    notifyListeners();
  }

  void setFavorites(List<String> values) {
    _favorites = values;
    notifyListeners();
  }

  void addCharacters(List<Character> values) {
    _characters.addAll(values);
    notifyListeners();
  }

  void onFavoriteModeChanged() {
    setFavoriteMode(!favoriteMode);
  }

  void onSearchModeChanged() {
    setSearchMode(!searchMode);
  }

  Future<void> onConnectionRetry() async {
    bool isConnected = await NetworkInfo.checkConnection();

    if (isConnected) {
      setHasMore(true);
      setHasConnection(true);
      await getCharactersFromApi();
    } else {
      Utils.showBottomMessage(context, Constants.errorMessage);
    }
  }

  Future<void> getCharacters() async {
    bool isConnected = await NetworkInfo.checkConnection();

    setHasConnection(isConnected);

    if (isConnected) {
      await getCharactersFromApi();
    } else {
      await _getCharactersFromStorage();
    }
  }

  Future<void> getCharactersFromApi() async {
    try {
      if (favoriteMode || !hasMore || !hasConnection) return;

      setIsLoading(true);

      int page = int.parse(swRequest?.next?.split("=").last ?? '1');

      SwRequest result = await PeopleService().getAll(page);

      addCharacters(result.characters);
      setSwRequest(result);

      notifyListeners();

      // sync local db
      CharactersRepository().saveCharacters(result.characters);
    } catch (e) {
      Utils.showBottomMessage(context, Constants.errorMessage);
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> _getCharactersFromStorage() async {
    try {
      setIsLoading(true);
      List<Character> characters = await CharactersRepository().getAll();

      addCharacters(characters);
      setHasMore(false);
    } catch (e) {
      Utils.showBottomMessage(context, Constants.errorMessage);
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> _getFavorites() async {
    List<String> favorites = await FavoritesRepository().getAll();
    setFavorites(favorites);
  }

  Future<void> _addFavorite(Character character) async {
    try {
      await FavoritesService().addFavorite(character);
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

  Future<void> _sendWaitingReqs() async {
    try {
      await FavoritesService().retryReqsIfAny();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> onItemFavorited(Character character, bool favorite) async {
    try {
      if (favorite) {
        await _removeFavorite(character);
      } else {
        await _addFavorite(character);
      }
    } catch (e) {
      Utils.showBottomMessage(context, Constants.errorMessage);
    }
  }
}
