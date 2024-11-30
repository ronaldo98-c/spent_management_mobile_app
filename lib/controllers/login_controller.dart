import 'package:flutter/material.dart';
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

    if (email.isEmpty || password.isEmpty) {
      throw InvalidException("Please fill all the given inputs!!", false);
    } else if (!emailValid) {
      throw InvalidException("Email is not valid!!", false);
    } else if (password.length < 8) {
      throw InvalidException("Password must be at least 8 characters long!!", false);
    }

    return true;
  }

  Future<dynamic> login(String email, String password) async {
    try {
      final valid = validate(email, password);
      if (valid) {
        return await _authService.login({
          "email": email,
          "password": password,
        });
      }
    } on InvalidException catch (e) {
      // Capture specific InvalidException and return it
      return Future.error(e);
    } catch (e) {
      // Handle other exceptions
      debugPrint("Unexpected error: $e");
      return Future.error(e);
    }

    return null;
  }


   Future<dynamic> signIn(String name, String email, String password) async {
    try {
      final valid = validate(email, password);
      if (valid) {
        return await _authService.signIn(
          {
            "name": name.toString(),
            "email": email.toString(),
            "password": password.toString()
          },
        );
      }
    } on InvalidException catch (e) {
      // Capture specific InvalidException and return it
      return Future.error(e);
    } catch (e) {
      // Handle other exceptions
      return Future.error(e);
    }

    return null;
  }

  Future<void> persistUserData(String? userData) async {
    try {
      // Sauvegarde les données utilisateur dans le stockage sécurisé
      await storage.write(key: "userData", value: userData);
    } catch (e) {
      // Capture et affiche les erreurs lors de l'écriture
      debugPrint("Erreur lors de la sauvegarde des données utilisateur : $e");
    }
  }

  Future<void> persistToken(String? token) async {
    try {
      // Sauvegarde les données utilisateur dans le stockage sécurisé
      await storage.write(key: "authToken", value: token);
    } catch (e) {
      // Capture et affiche les erreurs lors de l'écriture
      debugPrint("Erreur lors de la sauvegarde du token utilisateur : $e");
    }
  }

  Future<bool> hasToken() async {
    String? token = await storage.read(key: "authToken");
    bool result = token != null ? true : false;
    return result;
  }

  Future<void> deleteToken() async {
    await storage.delete(key: "authToken");
  }
}
