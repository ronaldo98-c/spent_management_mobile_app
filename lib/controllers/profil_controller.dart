import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilController {

  final storage = const FlutterSecureStorage();

  Future<String?> getUserData() async {
    try {
      // Lecture des données utilisateur depuis le stockage sécurisé
      return await storage.read(key: "userData");
    } catch (e) {
      // Capture et affiche les erreurs lors de la lecture
      debugPrint("Erreur lors de la récupération des données utilisateur : $e");
      return null; // Retourne `null` en cas d'erreur
    }
  }
  
  Future<String?> getToken() async{
    try {
      final token = await storage.read(key: "authToken");
      if (token != null) {
        return token;
      }
    } catch (e) {
      debugPrint("Erreur lors de la récupération des données utilisateur : $e");
    }
    return null;
  }
}
