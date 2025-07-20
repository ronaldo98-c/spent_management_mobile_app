import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:spent_mananagement_mobile/data_manager.dart';
import 'package:spent_mananagement_mobile/date_fetcher.dart';
import 'package:spent_mananagement_mobile/models/group.dart';
import 'package:spent_mananagement_mobile/models/spents.dart';
import 'package:spent_mananagement_mobile/constants/constant.dart';
import 'package:spent_mananagement_mobile/screens/widgets/group.dart';
import 'package:spent_mananagement_mobile/screens/widgets/add_group.dart';
import 'package:spent_mananagement_mobile/screens/widgets/page_list.dart';
import 'package:spent_mananagement_mobile/screens/widgets/add_spent.dart';
import 'package:spent_mananagement_mobile/controllers/api_controller.dart';
import 'package:spent_mananagement_mobile/screens/widgets/empty_list.dart';
import 'package:spent_mananagement_mobile/screens/widgets/filter_modal.dart';
import 'package:spent_mananagement_mobile/screens/widgets/squeleton_list.dart';

class SpentListScreen extends StatefulWidget {
  const SpentListScreen({super.key});

  @override
  State<SpentListScreen> createState() => _SpentListScreenState();
}

class _SpentListScreenState extends State<SpentListScreen> {
  late ApiController apiController;
  late DataManager<Spent> dataManager;
  late DataFetcher<Spent> dataFetcher;
  late DataManager<Group> groupManager;
  late DataFetcher<Group> groupFetcher;

  List<Spent> spentList = [];
  List<Spent> filterSpentList = [];
  List<Group> groups = [];
  int? selectedChipIndex;
  bool isLoadingSpents = false;
  bool isLoadingGroups = false;

  @override
  void initState() {
    super.initState();
    apiController = ApiController();
    groupManager = DataManager<Group>(apiController, 'group/list');
    groupFetcher = DataFetcher<Group>();
    fetchGroups();
  }

  // Récupérer les données de manière asynchrone
  void fetchSpents(int groupId) {
    dataManager = DataManager<Spent>(apiController, 'spent/list/$groupId');
    setState(() => isLoadingSpents = true);
    dataFetcher = DataFetcher<Spent>();

    dataFetcher.fetchAndSetData(
        fetchData: () => dataManager.fetchData((json) => Spent.fromJson(json)),
        onSetData: (data) => {
              setState(() => spentList = data),
              setState(() => filterSpentList = data)
            },
        onComplete: () => setState(() => isLoadingSpents = false),
        context: context);
  }

  // Récupérer les groupes
  void fetchGroups() {
    groupFetcher.fetchAndSetData(
        fetchData: () => groupManager
            .fetchData((json) => Group.fromJson(json)), // Exemple de parsing
        onSetData: (data) => setState(() => groups = data),
        onComplete: () => setState(() => isLoadingGroups = false),
        context: context);
  }

  //
  void updateSpentList(List<Spent> data) {
    setState(() => spentList = data);
  }

  //
  void updateGroupList(List<Group> data) {
    setState(() => groups = data);
  }

  //
  void updateSelectedChip(int index) {
    setState(() => selectedChipIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Partie gauche : Avatar et message de bienvenue
              const Column(
                children: [
                  Text(
                    'Dépenses',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Constants.singleGreyColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: IconButton(
                          onPressed: () {
                            FilterModal.showAddModal(
                                context, filterSpentList, updateSpentList);
                          },
                          icon: const Icon(Icons.filter_list),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Constants.singleGreyColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: IconButton(
                          onPressed: () {
                            AddSpent.showAddModal(
                                context,
                                spentList,
                                selectedChipIndex,
                                updateSpentList); // Show modal
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ),
                    ],
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
                children: [
                  Expanded(
                    child: GroupWidget(
                      groups: groups,
                      isLoadingGroups: isLoadingGroups,
                      fetchSpents: fetchSpents,
                      selectedChipIndex: selectedChipIndex,
                      updateSelectedChip: updateSelectedChip,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Constants.singleGreyColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: IconButton(
                      onPressed: () {
                        AddGroup.showAddModal(context, groups, updateGroupList); // Show modal
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Aligner à gauche
                      mainAxisSize:
                          MainAxisSize.min, // Ajuste la taille au contenu
                      children: [
                        Text(
                          "Total: ${spentList.fold(0, (sum, item) => sum + (item.amount))} FCFA",
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 4), // Espacement entre les textes
                        Text(
                          "Limite: ${groups.firstWhere((group) => group.id == selectedChipIndex, orElse: () => Group(id: 0, spendingLimit: 0, createdAt: '')).spendingLimit} FCFA",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4), 
                        Text(
                          "Reste: ${groups.firstWhere((group) => group.id == selectedChipIndex, orElse: () => Group(id: 0, spendingLimit: 0, createdAt: '')).spendingLimit - spentList.fold(0, (sum, item) => sum + (item.amount))} FCFA",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Skeletonizer(
                      // Added Skeletonizer
                      enabled: isLoadingSpents,
                      child: SizedBox(
                        height: spentList.isNotEmpty ? size.height * 0.75 : null,
                        child: isLoadingSpents
                            ? const SqueletonList() 
                            : spentList.isNotEmpty
                                ? ListView.builder(
                                    itemCount: spentList.length,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return PageList(
                                          index: index, spentList: spentList);
                                    },
                                  )
                                : const EmptyList(wording: "Aucune dépense")
                        ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
