import 'package:flutter/material.dart';

class DataFetcher<T> {
  // Simplification avec des callbacks intégrés
  Future<void> fetchAndSetData({
    required Future<List<T>> Function() fetchData,
    required void Function(List<T> data) onSetData,
    required VoidCallback onComplete,
    required BuildContext context
  }) async {
    try {
      final data = await fetchData(); 
      onSetData(data); 
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text( 'Erreur lors de la récupération des éléments : ${e.toString()}')),
      );
    } finally {
      onComplete(); // Action finale
    }
  }
}