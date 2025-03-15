
class Group {
  final int id;
  final String? name;
  final int spendingLimit;
  final String createdAt;

  Group({required this.id, this.name, required this.spendingLimit, required this.createdAt});
  
  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['name'],
      spendingLimit: json['spending_limit'],
      createdAt: json['created_at']
    );
  }
}