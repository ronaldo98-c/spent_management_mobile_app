import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:spent_mananagement_mobile/models/spents.dart';
import 'package:spent_mananagement_mobile/constants/constant.dart';

class PageList extends StatelessWidget {
  const PageList({
    super.key,
    required this.index,
    required this.spentList,
  });

  final int index;
  final List<Spent> spentList;

  @override
  Widget build(BuildContext context) {
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
                Icons.money_rounded,
                color: Colors.white,
                size: 24.0
              )
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    spentList[index].raison,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    spentList[index].desciption ?? '',
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
                  spentList[index].amount.toString() + r' XFA',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  )
                ),
                Text(
                  DateFormat('dd/MM/yyyy HH:mm')
                  .format(DateTime.parse(spentList[index].createdAt)),
                  style: const TextStyle(
                    color: Colors.grey
                  )
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}