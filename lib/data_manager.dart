import 'package:spent_mananagement_mobile/controllers/api_controller.dart';

class DataManager<T> {
  final ApiController apiController;
  final String endpoint;

  DataManager(this.apiController, this.endpoint);

  // Méthode pour récupérer des données
  Future<List<T>> fetchData(T Function(Map<String, dynamic>) fromJson) async {
    try {
      final List<dynamic> data;
      final response = await apiController.fetchData(endpoint);
      // Vérifiez que la réponse contient la clé "data"
      if (response is Map<String, dynamic> && response.containsKey('data')) {
        data = response['data'];
      } else {
        data = response;
      }

      if (data.isEmpty) {
        return [];
      }

      return data.map((item) => fromJson(item)).toList();

    } catch (e) {
      // Gestion améliorée des exceptions avec re-lancement
      throw Exception(
          'Erreur lors de la récupération des éléments : ${e.toString()}');
    }
  }

  // Méthode pour créer un nouvel élément
  Future<T> postData(Map<String, dynamic> body,
      Function(Map<String, dynamic>) fromJson) async {
    try {
      final data = await apiController.postData(endpoint, body);
      return fromJson(data);
    } catch (e) {
      throw Exception("Erreur lors de la création de l'élément : $e");
    }
  }

  // Méthode pour mettre à jour un élément
  Future<T> updateData(String id, Map<String, dynamic> body,
      Function(Map<String, dynamic>) fromJson) async {
    try {
      final data = await apiController.updateData('$endpoint/$id', body);
      return fromJson(data);
    } catch (e) {
      throw Exception("Erreur lors de la mise à jour de l'élément : $e");
    }
  }

  // Méthode pour supprimer un élément
  Future<void> deleteData(String id) async {
    try {
      await apiController.deleteData('$endpoint/$id');
    } catch (e) {
      throw Exception("Erreur lors de la suppression de l'élément : $e");
    }
  }
}
