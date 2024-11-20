import 'package:flutter/material.dart';
import 'package:spent_mananagement_mobile/constants/constant.dart';

class FilterModal {
  static Future<void> showAddModal(BuildContext context) async {
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
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: textField2Controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date', // Changed label to 'Date'
                    hintText: 'Choisir la date', // Changed hint text to 'Entrez la date'
                  ),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode()); // Prevent keyboard from showing
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000), // Set the first date
                      lastDate: DateTime(2101), // Set the last date
                    );
                    if (pickedDate != null) {
                      textField2Controller.text = "${pickedDate.toLocal()}".split(' ')[0]; // Format date
                    }
                  },
                ),
              ],
            )
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
              child: const Text('Appliquer'),
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