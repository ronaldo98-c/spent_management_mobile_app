import 'package:flutter/material.dart';
import 'package:spent_mananagement_mobile/constants/constant.dart';

class AddModal {
  static Future<void> showAddModal(BuildContext context) async {
    final TextEditingController textField1Controller = TextEditingController();
    final TextEditingController textField2Controller = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // Retirer les bordures
          ),
          contentPadding: const EdgeInsets.all(30),
          title: const Text('Ajouter une dépense'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: textField1Controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Libellé de la dépense',
                    hintText: 'Entrez lbellé de la dépense',
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: textField2Controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Montant',
                    hintText: 'Entrez le montant',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red ,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Assurez-vous que le rayon est 0
                ),
                minimumSize: const Size(100, 50)
              ),
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(); // Close modal
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Constants.darkBlueColor ,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Assurez-vous que le rayon est 0
                ),
                minimumSize: const Size(100, 50)
              ),
              child: const Text('Enregistrer'),
              onPressed: () {
                // Add your save logic here
                Navigator.of(context).pop(); // Close modal after saving
              },
            ),
          ],
        );
      },
    );
  }
}