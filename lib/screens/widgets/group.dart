import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:spent_mananagement_mobile/models/group.dart';
import 'package:spent_mananagement_mobile/constants/constant.dart';

class GroupWidget extends StatefulWidget {
  final List<Group> groups;
  final bool isLoadingGroups;
  final Function fetchSpents;
  final int? selectedChipIndex;
  final Function(int) updateSelectedChip;

  const GroupWidget(
      {super.key,
      required this.groups,
      required this.isLoadingGroups,
      required this.fetchSpents,
      required this.selectedChipIndex,
      required this.updateSelectedChip}); // Constructeur

  @override
  State<GroupWidget> createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: widget.isLoadingGroups // Vérification de l'état de chargement
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(4, (index) => buildChip())),
            )
          : Row(
              children: widget.groups.map((group) {
                // Utilisation de widget.groups
                int index = group.id;
                return GestureDetector(
                  onTap: () {
                    widget.updateSelectedChip(index);
                    widget.fetchSpents(group.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Chip(
                      label: Text(
                        group.name ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: widget.selectedChipIndex == index
                              ? Colors.white // Couleur lorsque sélectionné
                              : Constants.greyColor
                        )
                      ),
                      backgroundColor: widget.selectedChipIndex == index
                          ? Constants
                              .darkBlueColor // Couleur lorsque sélectionné
                          : Constants.singleGreyColor,
                      side: BorderSide(
                        color: widget.selectedChipIndex == index
                            ? Constants
                                .darkBlueColor // Couleur de bordure lorsque sélectionné
                            : Constants.singleGreyColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}

// Skeleton or Chip
Widget buildChip() {
  return Skeletonizer(
    enabled: true,
    child: Container(
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          color: Constants.greyColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: null),
  );
}
