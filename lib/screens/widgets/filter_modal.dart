import 'package:flutter/material.dart';
import 'package:spent_mananagement_mobile/constants/constant.dart';
import 'package:spent_mananagement_mobile/models/spents.dart';

class FilterModal {
  final List<Spent> filterSpentList;
  final Function(List<Spent>) updateSpentList;

  FilterModal(this.filterSpentList, this.updateSpentList);

  static Future<void> showAddModal(
      BuildContext context,
      List<Spent> filterSpentList,
      Function(List<Spent>) updateSpentList) async {
    final TextEditingController startDateController = TextEditingController();
    final TextEditingController endDateController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          contentPadding: const EdgeInsets.all(30),
          content: SingleChildScrollView(
              child: Column(
            children: [
              TextFormField(
                controller: startDateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Date debut', // Changed label to 'Date'
                  hintText:
                      'Choisir la date', // Changed hint text to 'Entrez la date'
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(
                      FocusNode()); // Prevent keyboard from showing
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000), // Set the first date
                    lastDate: DateTime(2101), // Set the last date
                  );
                  if (pickedDate != null) {
                    startDateController.text =
                        "${pickedDate.toLocal()}".split(' ')[0]; // Format date
                  }
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: endDateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Date de fin', // Changed label to 'Date'
                  hintText:
                      'Choisir la date', // Changed hint text to 'Entrez la date'
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(
                      FocusNode()); // Prevent keyboard from showing
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000), // Set the first date
                    lastDate: DateTime(2101), // Set the last date
                  );
                  if (pickedDate != null) {
                    endDateController.text =
                        "${pickedDate.toLocal()}".split(' ')[0]; // Format date
                  }
                },
              ),
            ],
          )),
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
              child: const Text('Filtrer'),
              onPressed: () {
                List<Spent> filteredList = _filterSpentList(
                    filterSpentList,
                    startDateController.text,
                    endDateController.text); // Appeler la fonction de filtrage
                updateSpentList(
                    filteredList); // Mettre à jour spentList dans le parent
                Navigator.of(context).pop(); // Close modal after filtering
              },
            ),
          ],
        );
      },
    );
  }

  // Fonction pour filtrer spentList en fonction de createdAt
  static List<Spent> _filterSpentList(
      List<Spent> spentList, String startDate, String endDate) {
    DateTime? filterStartDate =
        DateTime.tryParse(startDate); // Convertir la date en DateTime
    DateTime? filterEndDate =
        DateTime.tryParse(endDate); // Convertir la date en DateTime
    if (filterStartDate != null && filterEndDate != null) {
      List<Spent> filteredList = spentList.where((spent) {
        DateTime spentDate = DateTime.parse(spent.createdAt)
            .toLocal(); // Convertir en DateTime local

        // Vérifier si la date est dans l'intervalle
        return spentDate
                .isAfter(filterStartDate.subtract(const Duration(days: 1))) &&
            spentDate.isBefore(filterEndDate.add(const Duration(days: 1)));
      }).toList();

      return filteredList; // Retourner la liste filtrée
    } else {
      debugPrint('Date invalide'); // Gérer les dates invalides
      return []; // Retourner une liste vide en cas de date invalide
    }
  }
}
