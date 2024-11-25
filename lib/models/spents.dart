
class Spent {
  final int id;
  final int amount;
  final String raison;
  final String? desciption;
  final String createdAt;

  Spent({required this.id, required this.amount,  required this.raison, this.desciption, required this.createdAt});
  
  factory Spent.fromJson(Map<String, dynamic> json) {
    return Spent(
      id: json['id'],
      amount: json['amount'],
      raison: json['raison'],
      desciption: json['description'],
      createdAt: json['created_at']
    );
  }
}