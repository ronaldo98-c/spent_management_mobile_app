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
    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: widget.isLoadingGroups
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(4, (index) => 
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: buildChip(),
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.groups.expand((group) {
                    int index = group.id;
                    return [
                      Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: GestureDetector(
                          onTap: () {
                            widget.updateSelectedChip(index);
                            widget.fetchSpents(group.id);
                          },
                          child: Chip(
                            label: Text(
                              group.name ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: widget.selectedChipIndex == index
                                    ? Colors.white
                                    : Constants.greyColor,
                              ),
                            ),
                            backgroundColor: widget.selectedChipIndex == index
                                ? Constants.darkBlueColor
                                : Constants.singleGreyColor,
                            side: BorderSide(
                              color: widget.selectedChipIndex == index
                                  ? Constants.darkBlueColor
                                  : Constants.singleGreyColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ];
                  }).toList(),
                ),
        ),
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
