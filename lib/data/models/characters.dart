class Character {
  late int id;
  late String name;
  late String image;
  late String status;
  late List<dynamic> appearanceInEpisodes;

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    appearanceInEpisodes = json['episode'];
  }
}
