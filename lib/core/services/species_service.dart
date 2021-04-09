import 'package:star_wars_wiki/core/utils/http_helper.dart';

class SpeciesService {
  static get path => '/species/';

  Future<String> getSpecieById(String id) async {
    try {
      var response = await HttpHelper().invokeHttp(
        path + '/$id',
        RequestType.get,
      );

      return response['name'];
    } catch (e) {
      rethrow;
    }
  }
}
