import 'package:flutter/material.dart';
import 'package:spent_mananagement_mobile/models/plants.dart';
import 'package:spent_mananagement_mobile/constants/constant.dart';

class PageList extends StatelessWidget {
  const PageList({
    super.key,
    required this.index,
    required this.plantList,
  });

  final int index;
  final List<Plant> plantList;

  @override
  Widget build(BuildContext context) {
  //  Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () { },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
             CircleAvatar(
              backgroundColor: Constants.darkBlueColor,
              radius: 20.0,
              child:  const Icon(
                Icons.directions_bus,
                color: Colors.white,
                size: 24.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plantList[index].plantName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    plantList[index].category,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  r'$' + plantList[index].price.toString(),
                  style: TextStyle(
                    color: plantList[index].isFavorated ? Colors.green : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const Text(
                  '2021-01-12 13h50',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}