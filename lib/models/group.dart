
class Group {
  final int id;
  final String? name;
  final String createdAt;

  Group({required this.id, this.name, required this.createdAt});
  
  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at']
    );
  }
}