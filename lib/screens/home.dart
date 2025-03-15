import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:spent_mananagement_mobile/blocs/app.dart';
import 'package:spent_mananagement_mobile/constants/image_constants.dart';
import 'package:spent_mananagement_mobile/data_manager.dart';
import 'package:spent_mananagement_mobile/date_fetcher.dart';
import 'package:spent_mananagement_mobile/models/group.dart';
import 'package:spent_mananagement_mobile/constants/constant.dart';
import 'package:spent_mananagement_mobile/screens/spent_list.dart';
import 'package:spent_mananagement_mobile/models/expense_data.dart';
import 'package:spent_mananagement_mobile/screens/widgets/page_list.dart';
import 'package:spent_mananagement_mobile/controllers/api_controller.dart';
import 'package:spent_mananagement_mobile/screens/widgets/empty_list.dart';
import 'package:spent_mananagement_mobile/screens/statistic/bar_chart.dart';
import 'package:spent_mananagement_mobile/controllers/profil_controller.dart';
import 'package:spent_mananagement_mobile/screens/widgets/squeleton_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String? user = "...";
  late ApiController apiController;
  late DataManager<Group> groupManager;
  late DataFetcher<Group> groupFetcher;

  bool isLoading = false;
  int? selectedGroup = 1;
  List<Group> groups = [];
  String? selectedValue =  DateTime.now().year.toString();
  ExpensesData expensesData = ExpensesData(data: [], spent: []);

  final List<String> itemList = List<String>.generate(8, (index) {
    return (DateTime.now().year - index).toString();
  });

  @override
  void initState() {
    super.initState();
    apiController = ApiController();
    groupManager = DataManager<Group>(apiController, 'group/list');
    groupFetcher = DataFetcher<Group>();
    fetchGroups();
    _loadUserData();
  }

  // Récupérer les groupes
  void fetchGroups() {
    groupFetcher.fetchAndSetData(
        fetchData: () => groupManager.fetchData((json) => Group.fromJson(json)),
        onSetData: (data) => setState(() => groups = data),
        onComplete: () => {},
        context: context);
  }

  // Récupérer les données des dépenses
  void fetchExpenseData(groupId, year) {
    setState(() => isLoading = true);
    apiController
        .fetchData('spent/statistic?group_id=$groupId&year=$year')
        .then((data) {
      setState(() {
        isLoading = false;
        expensesData = ExpensesData.fromJson(data);
      });
    }).catchError((error) {
      setState(() => isLoading = false);
      debugPrint(
          "Erreur lors de la récupération des données : ${error.toString()}");
    });
  }

  Future<void> _loadUserData() async {
    final loadedUser = await ProfilController().getUserData();
    setState(() {
      user = loadedUser; // Fin du chargement
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Partie gauche : Avatar et message de bienvenue
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage:  AssetImage(AppImages.user),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bienvenu',
                      style:
                          TextStyle(fontSize: 14, color: Constants.greyColor),
                    ),
                    Text(
                      "Mr, $user",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Partie droite : Icones
            IconButton(
              icon: const Stack(
                children: [
                  Icon( Icons.logout_outlined, color: Colors.black)
                ],
              ),
              onPressed: () {
                BlocProvider.of<AppBloc>(context).add(LoggedOut());
              },
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
                    'Statistiques',
                    style: TextStyle(
                      color: Constants.darkBlueColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value:
                                selectedGroup, // Vérification de la valeur initiale
                            dropdownColor: Colors.white,
                            items: groups
                                .map<DropdownMenuItem<int>>((Group value) {
                              return DropdownMenuItem<int>(
                                value: value
                                    .id, // S'assurer que `value.name` n'est pas null
                                child: SizedBox(
                                  width: 80,
                                  child: Text(
                                    value.name ??
                                        'Inconnu', // Fallback pour les valeurs nulles
                                    style: TextStyle(
                                      color: Constants.greyColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              );
                            }).toList(), // toSet() non nécessaire si `value.name` est unique
                            onChanged: (int? newValue) {
                              setState(() {
                                selectedGroup =
                                    newValue; // Gérer les valeurs nulles
                              });
                              fetchExpenseData(newValue, selectedValue);
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedValue,
                            dropdownColor: Colors.white,
                            items:
                                itemList.map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Constants.greyColor),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue = newValue;
                              });
                              fetchExpenseData(selectedGroup, newValue);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              BarChartSample(
                title: 'Entrée annuelle',
                isLoading: isLoading,
                data: expensesData.data,
                period: Constants.months,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dernières dépenses",
                    style: TextStyle(
                      fontSize: 18,
                      color: Constants.darkBlueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SpentListScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Voir plus",
                      style:
                          TextStyle(fontSize: 13, color: Constants.greyColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Skeletonizer(
                  enabled: isLoading,
                  child: SizedBox(
                      height: expensesData.spent.isNotEmpty ? 300 : null,
                      child: isLoading
                          ? const SqueletonList()
                          : expensesData.spent.isNotEmpty
                              ? ListView.builder(
                                  padding: const EdgeInsets.all(8.0),
                                  itemCount: expensesData.spent.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return PageList(
                                        index: index,
                                        spentList: expensesData.spent);
                                  },
                                )
                              : const EmptyList(wording: "Aucune dépense"))),
            ],
          ),
        ),
      ),
    );
  }
}
