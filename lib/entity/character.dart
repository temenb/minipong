class Character {
  final String id;
  final String name;

  Character({String? id, required this.name})
      : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  static Character fromJson(Map<String, dynamic> json) =>
      Character(id: json['id'], name: json['name']);
}
