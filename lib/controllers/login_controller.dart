import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:spent_mananagement_mobile/services/auth_service.dart';
import 'package:spent_mananagement_mobile/services/base/app_exceptions.dart';

class LoginController {

  final storage = const FlutterSecureStorage();
  final AuthService _authService = AuthService(); 


  // validate login form
  bool validate(String email, String password) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    try {
      if ( email == "" || password == "") {
        throw InvalidException("please fill all given inputs !!", false);
      } else {
        if (emailValid) {
          if (password.length >= 8) {
            return true;
          } else {
            throw InvalidException("password must be greater than 8 !!", false);
          }
        } else {
          throw InvalidException("Email is not valid !!", false);
        }
      }
    } catch (e) {
     // handleError(context , e);
      return false;
    }
  }

  Future<String?>login( String email, String password) async {
    
    final valid = validate(email , password);
    if (valid) {
      return await _authService.login(
        {
          "email": email.toString(),
          "password":password.toString(),
        },
      );
    }
    return null;
  }

  Future<void> persistToken(String? token) async{
    storage.write(key: "authToken", value: token);
  }

  Future<bool>hasToken() async{
    String? token = await storage.read(key: "authToken");
    bool result = token != null ? true : false;
    return result;
  }

  Future<void> deleteToken() async{
    await storage.delete(key: "authToken");
  }
}
