import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spent_mananagement_mobile/constants/constant.dart';
import 'package:spent_mananagement_mobile/controllers/api_controller.dart';
import 'package:spent_mananagement_mobile/models/spents.dart';

class AddModal<T> {
  final List<Spent> itemList;
  final int? selectedChipIndex;
  final Function(List<Spent>) updateSpentList;

  AddModal(this.itemList, this.selectedChipIndex,
      this.updateSpentList); // Constructeur pour initialiser la liste

  static Future<void> showAddModal<T>(
      BuildContext context,
      List<Spent> itemList,
      int? selectedChipIndex,
      Function(List<Spent>) updateSpentList) async {
    final TextEditingController textField1Controller = TextEditingController();
    final TextEditingController textField2Controller = TextEditingController();
    final TextEditingController textAreaController = TextEditingController();

    bool isLoading = false; // Variable d'état pour le loader

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          contentPadding: const EdgeInsets.all(30),
          title: const Text('Nouvelle'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: textField1Controller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Raison',
                      hintText: 'Entrez la raison de la dépense'),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: textField2Controller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Montant',
                      hintText: 'Entrez le montant'),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: textAreaController,
                  maxLines: 3,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  minimumSize: const Size(100, 50)),
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(); // Close modal
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Constants.darkBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  minimumSize: const Size(100, 50)),
              onPressed: isLoading
                  ? null // Désactiver le bouton si le loader est affiché
                  : () async { // Make the function async
                      if (selectedChipIndex == null) {
                        // Vérifier si selectedChipIndex est null

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Veuillez sélectionner un groupe.')),

                        );
                        return; // Sortir de la fonction si selectedChipIndex est null
                      }
                      // Vérifier si tous les TextFields sont renseignés
                      if (textField1Controller.text.isEmpty ||
                          textField2Controller.text.isEmpty ||
                          textAreaController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Veuillez remplir tous les champs.')),);
                        return; // Sortir de la fonction si des champs sont vides
                      }

                      // Set isLoading to true before calling _handleAddItem
                      isLoading = true; // Update loading state
                      await _handleAddItem( // Await the function call
                          textField1Controller,
                          textField2Controller,
                          textAreaController,
                          itemList,
                          context,
                          selectedChipIndex,
                          updateSpentList,
                          isLoading);
                    },
              child: isLoading
                  ? const CircularProgressIndicator() // Afficher le loader
                  : const Text('Enregistrer'),

            ),

          ],
        );
      },
    );
  }

  // Nouvelle méthode pour gérer l'ajout d'un élément
  // Nouvelle méthode pour gérer l'ajout d'un élément
  static Future<void> _handleAddItem<T>(
      // Change to return Future<void>
      TextEditingController textField1Controller,
      TextEditingController textField2Controller,
      TextEditingController textAreaController,
      List<Spent> itemList,
      BuildContext context,
      int? selectedChipIndex,
      Function(List<Spent>) updateSpentList,
       bool isLoading) async {
    // Make it async
    // Récupérer les valeurs des contrôleurs de texte
    isLoading = true;
    String raison = textField1Controller.text;
    String amount = textField2Controller.text;
    String description = textAreaController.text;

    // Construire l'objet newItem sous forme de Map
    Map<String, dynamic> newItem = {
      "group_id":
          selectedChipIndex, // Remplacez par la valeur appropriée si nécessaire
      "amount": int.tryParse(amount) ?? 0, // Convertir le montant en entier
      "raison": raison,
      "description": description
    };

    // Appel de l'ApiController pour envoyer les données
    ApiController apiController = ApiController();
    try {
      final response = await apiController.postData('spent/store', newItem); // Await the response
      // Gérer la réponse ici
      isLoading = false;
      itemList.add(Spent.fromJson(response['data']));
      updateSpentList(itemList);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Fermer le modal
    } catch (error) {
      isLoading = false;
      // Gérer les erreurs ici
      debugPrint('Erreur lors de l\'envoi des données: $error');
    }
  }
}
