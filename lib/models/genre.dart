class Genre {
  late int id;
  late String name;
  late int movies_count;
  Genre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    movies_count = json['movies_count'] ?? 0;
  }
}
