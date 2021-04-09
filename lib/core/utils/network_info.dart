import 'dart:io';

class NetworkInfo {
  static Future<bool> checkConnection() async {
    bool isConnected;

    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      } else {
        isConnected = false;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }

    return isConnected;
  }
}
