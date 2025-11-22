import 'dart:convert';

class Item {
  String id;
  String title;
  String description;
  DateTime createdAt;

  Item({
    required this.id,
    required this.title,
    required this.description,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Item.fromMap(Map<String, dynamic> m) => Item(
        id: m['id'],
        title: m['title'],
        description: m['description'],
        createdAt: DateTime.parse(m['createdAt']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'createdAt': createdAt.toIso8601String(),
      };

  static List<Item> listFromJson(String jsonStr) {
    final List<dynamic> data = json.decode(jsonStr);
    return data.map((e) => Item.fromMap(e)).toList();
  }

  static String listToJson(List<Item> items) {
    final List<Map<String, dynamic>> data =
        items.map((e) => e.toMap()).toList();
    return json.encode(data);
  }
}
