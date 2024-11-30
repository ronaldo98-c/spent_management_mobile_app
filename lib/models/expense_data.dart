import 'package:spent_mananagement_mobile/models/spents.dart';

class ExpensesData {
  final List<double> data;
  final List<Spent> spent;

  ExpensesData({required this.data, required this.spent});

  factory ExpensesData.fromJson(Map<String, dynamic> json) {
    return ExpensesData(
      data: List<double>.from(json['totalMonthsOfYearAmountSpent'].map((item) => item.toDouble())),
      spent: List<Spent>.from(json['lastSpent'].map((item) =>  
      Spent(
        id: item['id'],
        amount: item['amount'],
        raison: item['raison'],
        desciption: item['description'],
        createdAt: item['created_at']
      ) 
    ))
    );
  }
}