import 'package:flutter/material.dart';
import 'package:spent_mananagement_mobile/models/group.dart';
import 'package:spent_mananagement_mobile/constants/constant.dart';
import 'package:spent_mananagement_mobile/controllers/api_controller.dart';


class AddGroup<T> {
  final List<Group> itemList;
  final Function(List<Group>) updateGroupList;

  AddGroup(this.itemList, this.updateGroupList); // Constructeur pour initialiser la liste

  static Future<void> showAddModal<T>(
      BuildContext context,
      List<Group> itemList,
      Function(List<Group>) updateGroupList) async {
    final TextEditingController textField1Controller = TextEditingController();

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
                      labelText: 'Nom',
                      hintText: 'Entrez le nom du groupe'),
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
                  : () async { 
                      // Vérifier si tous les TextFields sont renseignés
                      if (textField1Controller.text.isEmpty ) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Veuillez remplir tous les champs.')),);
                        return; // Sortir de la fonction si des champs sont vides
                      }

                      // Set isLoading to true before calling _handleAddItem
                      isLoading = true; // Update loading state
                      await _handleAddItem( // Await the function call
                          textField1Controller,
                          itemList,
                          context,
                          updateGroupList,
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
      List<Group> itemList,
      BuildContext context,
      Function(List<Group>) updateGroupList,
       bool isLoading) async {
    // Make it async
    // Récupérer les valeurs des contrôleurs de texte
    isLoading = true;
    String name = textField1Controller.text;

    // Construire l'objet newItem sous forme de Map
    Map<String, dynamic> newItem = { // Convertir le montant en entier
      "name": name,
    };

    // Appel de l'ApiController pour envoyer les données
    ApiController apiController = ApiController();
    try {
      final response = await apiController.postData('group/store', newItem); // Await the response
      // Gérer la réponse ici
      isLoading = false;
      itemList.add(Group.fromJson(response['data']));
      updateGroupList(itemList);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Fermer le modal
    } catch (error) {
      isLoading = false;
      // Gérer les erreurs ici
      debugPrint('Erreur lors de l\'envoi des données: $error');
    }
  }
}
