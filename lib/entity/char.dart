class Char {
  final String id;
  final String name;

  Char({required this.id, required this.name});

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  static Char fromJson(Map<String, dynamic> json) =>
      Char(id: json['id'], name: json['name']);
}

