class Movie {
  final int id;
  final String title;
  final String plot;
  final String releaseDate;
  final String genre;
  final String director;
  final String photoFilename;
  final List<String> actors;

  Movie({
    required this.id,
    required this.title,
    required this.plot,
    required this.releaseDate,
    required this.genre,
    required this.director,
    required this.photoFilename,
    required this.actors,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      plot: json['plot'],
      releaseDate: json['releaseDate'],
      genre: json['genre'],
      director: json['director'],
      photoFilename: json['photoFilename'],
      actors: List<String>.from(json['actors']),
    );
  }
}
