import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_wars_wiki/core/models/character.dart';
import 'package:star_wars_wiki/core/utils/constants.dart';
import 'package:star_wars_wiki/core/utils/http_helper.dart';

class FavoritesService {
  static get path => '/favorite/';
  Future<void> addFavorite(Character character) async {
    try {
      Uri uri = Uri.http(Constants.favoritesUrl, path + '${character.name}');

      await HttpHelper().invokeHttp(
        path,
        RequestType.post,
        customUri: uri,
      );
    } catch (e) {
      _saveReqForRetry(character);
      rethrow;
    }
  }

  Future<void> retryReqsIfAny() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String>? reqs = prefs.getStringList(Constants.reqPrefs);

      if (reqs != null) {
        reqs.forEach((char) async {
          Character character = Character.fromJson(char);
          await addFavorite(character);
          reqs.removeAt(reqs.indexOf(char));
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _saveReqForRetry(Character character) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? reqs = prefs.getStringList(Constants.reqPrefs);

    if (reqs == null) reqs = [];

    reqs.add(character.toJson());

    await prefs.setStringList(Constants.reqPrefs, reqs);
  }
}
