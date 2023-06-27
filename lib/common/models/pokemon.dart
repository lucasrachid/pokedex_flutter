
class Pokemon {
  final int id;
  final String name;
  final String image;
  final List<String> type;
  final String num;

  factory Pokemon.fromMap(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      image: json['img'],
      type: (json['type'] as List<dynamic>)
          .map(
            (element) => element as String,
          )
          .toList(),
      num: json['num'],
    );
  }

  Pokemon({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    required this.num,
  });
}
