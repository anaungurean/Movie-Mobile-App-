class Actor {
  final int id;
  final String name;
  final String biography;
  final String dateOfBirth;
  final String photoFilename;

  Actor({
    required this.id,
    required this.name,
    required this.biography,
    required this.dateOfBirth,
    required this.photoFilename,
  });

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      id: json['id'],
      name: json['name'],
      biography: json['biography'],
      dateOfBirth: json['dateOfBirth'],
      photoFilename: json['photoFilename'],
    );
  }
}
