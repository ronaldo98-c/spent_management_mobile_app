import 'package:flutter/material.dart';
import 'package:spent_mananagement_mobile/models/plants.dart';
import 'package:spent_mananagement_mobile/constants/constant.dart';
import 'package:spent_mananagement_mobile/screens/spent_list.dart';
import 'package:spent_mananagement_mobile/screens/widgets/page_list.dart';
import 'package:spent_mananagement_mobile/screens/statistic/bar_chart.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 List<Plant> plantList = Plant.plantList.take(3).toList();

  final List itemList = [
    "2024",
    "2023",
    "2022",
    "2021",
    "2020",
    "2019",
    "2018",
    "2017"
  ];
  String? selectedValue = "2024";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side with avatar and welcome text
             Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/005/545/335/small/user-sign-icon-person-symbol-human-avatar-isolated-on-white-backogrund-vector.jpg'), // Use a local image or network image here
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bienvenu',
                      style: TextStyle(
                        fontSize: 14,
                        color: Constants.greyColor
                      ),
                    ),
                    const Text(
                      'Mr Ronaldo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Right side with icons
            Row(
              children: [
                IconButton(
                  icon: const Stack(
                    children: [
                      Icon(Icons.notifications, color: Colors.black),
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          radius: 4,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [
                 Text(
                  'Statistics',
                  style: TextStyle(
                      color: Constants.darkBlueColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: selectedValue,
                    dropdownColor: Colors.white,
                    items: itemList.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Constants.greyColor,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                  ),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              BarChartSample(title: 'Entrée annuelle', jsonString:'expenses_year_data.json', period: Constants.months) ,
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text(
                    "Dernieres dépenses",
                    style: TextStyle(
                        fontSize: 18,
                        color: Constants.darkBlueColor,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector( // Ajout de GestureDetector
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SpentListScreen()
                        )
                      ); // Remplacez '/spenList' par le nom de la route de votre SpenListScreen
                    },
                    child: Text(
                      "Voir plus",
                      style: TextStyle(
                          fontSize: 13,
                          color: Constants.greyColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 300, // Définissez une hauteur pour le ListView
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: plantList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PageList(index: index, plantList: plantList);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}