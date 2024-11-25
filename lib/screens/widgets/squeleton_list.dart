import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:spent_mananagement_mobile/constants/constant.dart';


class SqueletonList extends StatelessWidget {
  const SqueletonList({super.key});

   @override
  Widget build(BuildContext context) {
    return  Skeletonizer(
      child: SizedBox(
        height: 300,
        child: Column(
          children: List.generate(4, (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Constants.darkBlueColor,
                radius: 20.0,
                child:  const Icon(
                  Icons.money_rounded,
                  color: Colors.white,
                  size: 24.0
                )
              ),
              const SizedBox(width: 16.0),
              const Expanded(
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Achat du pain",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      "Pour la pause",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:  [
                  Text(
                    "200 XFA",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    )
                  ),
                  Text("2021-12-15 15h 00",
                    style: TextStyle(
                      color: Colors.grey
                    )
                  ),
                ],
              ),
            ],
          ),
        ))
        )
      )
    );
  }
}