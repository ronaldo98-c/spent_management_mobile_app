
import 'package:flutter/material.dart';
import 'package:spent_mananagement_mobile/constants/constant.dart';

class GroupWidget extends StatefulWidget {
  final List<String> groups; // Paramètre pour les catégories

  const GroupWidget({super.key, required this.groups}); // Constructeur

  @override
   State<GroupWidget> createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.groups.map((category) { // Utilisation de widget.categories
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Chip(
              label: Text(
                category,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              backgroundColor: Constants.greyColor,
              side: BorderSide(color: Constants.greyColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}