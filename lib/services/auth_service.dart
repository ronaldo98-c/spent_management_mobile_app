import 'package:flutter/foundation.dart';
import 'package:spent_mananagement_mobile/services/base/base_client.dart';
import 'package:spent_mananagement_mobile/constants/network_constants.dart';

class AuthService {
  final BaseClient _baseClient = BaseClient();

  // !! login method
  Future<String?>login(dynamic object) async {
    try {
      var result = await _baseClient.post(
        NetworkConstants.loginAPI,
        object
      );
      //var result = json.decode(response.body);
      if (result["success"]) {
        final String? token = result["data"]["token"];
        return token;
      }
    } catch (e) {
      debugPrint("Login error: $e");
    }
    return null;
  }
}