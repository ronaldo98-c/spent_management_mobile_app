import 'package:spent_mananagement_mobile/services/base/base_client.dart';
import 'package:spent_mananagement_mobile/services/base/app_exceptions.dart';

class ApiController {
  final BaseClient _baseClient;

  ApiController() : _baseClient = BaseClient();

  // Exemple d'utilisation générique pour un GET
  Future<dynamic> fetchData(String endpoint, {Map<String, String>? params}) async {
    try {
      return await _baseClient.get(endpoint, queryParams: params);
    } catch (e) {
      throw FetchDataException('Erreur lors de la récupération des données: $e', endpoint);
    }
  }

  // Exemple d'utilisation générique pour un POST
  Future<dynamic> postData(String endpoint, Map<String, dynamic> data) async {
    try {
      return await _baseClient.post(endpoint, data);
    } catch (e) {
      throw InternalServerException('Erreur lors de l\'envoi des données: $e', endpoint);
    }
  }

  // Exemple d'utilisation générique pour un PUT
  Future<dynamic> updateData(String endpoint, Map<String, dynamic> data) async {
    try {
      return await _baseClient.put(endpoint, data);
    } catch (e) {
      throw InternalServerException(
          'Erreur lors de la mise à jour des données: $e', endpoint);
    }
  }

  // Exemple d'utilisation générique pour un DELETE
  Future<dynamic> deleteData(String endpoint) async {
    try {
      return await _baseClient.delete(endpoint);
    } catch (e) {
      throw InternalServerException(
          'Erreur lors de la suppression des données: $e', endpoint);
    }
  }
}
