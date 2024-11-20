import 'package:flutter/material.dart';
import 'package:spent_mananagement_mobile/models/spents.dart';
import 'package:spent_mananagement_mobile/constants/constant.dart';
import 'package:spent_mananagement_mobile/screens/widgets/group.dart';
import 'package:spent_mananagement_mobile/screens/widgets/page_list.dart';
import 'package:spent_mananagement_mobile/screens/widgets/add_modal.dart';
import 'package:spent_mananagement_mobile/screens/widgets/filter_modal.dart';


class SpentListScreen extends StatefulWidget {
  const SpentListScreen({super.key});

  @override
  State<SpentListScreen> createState() => _SpentListScreenState();
}

class _SpentListScreenState extends State<SpentListScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Spent> spentList = Spent.spentList;
    List<String> groups = [ 'PROMOTION', 'Climatiseurs/Ventilateurs', 'Générateurs', 'Électroménagers'];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Dépenses',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Constants.greyColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: IconButton(
                          onPressed: () {
                            FilterModal.showAddModal(context);
                          },
                          icon: const Icon(Icons.filter_list),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Constants.greyColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: IconButton(
                          onPressed: () {
                            AddModal.showAddModal(context); // Show modal
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            GroupWidget(groups: groups),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: size.height,
                    child: ListView.builder(
                      itemCount: spentList.length,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return PageList(index: index, spentList: spentList);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}