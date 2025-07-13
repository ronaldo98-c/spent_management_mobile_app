import 'package:flutter/material.dart';
import 'package:spent_mananagement_mobile/constants/constant.dart';

class EmptyList extends StatefulWidget {
  final String wording;
  const EmptyList({super.key, required this.wording});

  @override
    State<EmptyList> createState() => _EmptyList();
}

class _EmptyList extends State<EmptyList> {

  @override
  Widget build(BuildContext context) {
     return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icône ou logo
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Constants.singleGreyColor,
            ),
            child: Icon(
              Icons.open_in_new,
              size: 40,
              color: Constants.greyColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.wording,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Constants.darkBlueColor,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}