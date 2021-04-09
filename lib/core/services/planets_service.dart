import 'package:star_wars_wiki/core/utils/http_helper.dart';

class PlanetsService {
  static get path => '/planets/';

  Future<String> getPlanetById(String id) async {
    try {
      var response = await HttpHelper().invokeHttp(
        path + '$id',
        RequestType.get,
      );

      return response['name'];
    } catch (e) {
      rethrow;
    }
  }
}
