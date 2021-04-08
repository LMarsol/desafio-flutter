import 'package:star_wars_wiki/core/models/sw_request.dart';
import 'package:star_wars_wiki/core/utils/http_helper.dart';

class PeopleService {
  static get path => '/people/';

  Future<SwRequest> getAll(int page) async {
    try {
      var queryParams = {
        'page': '$page',
      };

      var response = await HttpHelper().invokeHttp(
        path,
        RequestType.get,
        queryParameters: queryParams,
      );

      SwRequest swRequest = SwRequest.fromMap(response);

      return swRequest;
    } catch (e) {
      rethrow;
    }
  }
}
