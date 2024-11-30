import 'package:flutter/foundation.dart';
import 'package:spent_mananagement_mobile/services/base/base_client.dart';
import 'package:spent_mananagement_mobile/constants/network_constants.dart';

class AuthService {
  final BaseClient _baseClient = BaseClient();

  // !! login method
  Future<dynamic>login(dynamic object) async {
    try {
      var result = await _baseClient.post(
        NetworkConstants.loginAPI,
        object
      );
      if (result["success"]) {
        return result;
      }
    } catch (e) {
      debugPrint("Login error: $e");
    }
    return null;
  }

  // !! Sign in method
  Future<dynamic>signIn(dynamic object) async {
    try {
      var result = await _baseClient.post(
        NetworkConstants.registerAPI,
        object
      );
      //var result = json.decode(response.body);
      if (result["success"]) {
        return result;
      }
    } catch (e) {
      debugPrint("Login error: $e");
    }
    return null;
  }
}