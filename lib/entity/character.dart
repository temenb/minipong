class Character {
  final String id;
  final String name;

  Character({required this.id, required this.name});

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  static Character fromJson(Map<String, dynamic> json) =>
      Character(id: json['id'], name: json['name']);
}

