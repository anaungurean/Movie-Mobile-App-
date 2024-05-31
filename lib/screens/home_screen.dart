import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mobile_project/models/actor.dart';
import 'dart:math';
import 'package:mobile_project/screens/movieProfile_screen.dart';
import 'package:mobile_project/models/movie.dart';
import 'package:mobile_project/screens/login_screen.dart';
import 'package:mobile_project/screens/favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  List<Movie> movies = [];
  List <Actor> actors = [];
  List<Movie> randomMovies = [];
  List<Movie> recommendedMovies = [];
  List<Movie> newMovies = [];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String response =
        await rootBundle.loadString('lib/assets/data/movies.json');
    final data = await json.decode(response);

    setState(() {
      movies =
          (data['movies'] as List).map((json) => Movie.fromJson(json)).toList();
      actors =
          (data['actors'] as List).map((json) => Actor.fromJson(json)).toList();
      randomMovies = getRandomMovies(3, movies);
      recommendedMovies = getRandomMovies(5, movies);
      newMovies = getRecentMovies(5, movies);
    });
  }

  List<Movie> getRandomMovies(int count, List<Movie> source) {
    final random = Random();
    List<Movie> randomMovies = [];

    while (randomMovies.length < count) {
      int randomIndex = random.nextInt(source.length);
      Movie randomMovie = source[randomIndex];

      if (!randomMovies.contains(randomMovie)) {
        randomMovies.add(randomMovie);
      }
    }

    return randomMovies;
  }

  List<Movie> getRecentMovies(int count, List<Movie> source) {
    source.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));
    return source.take(count).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.movie, color: Colors.teal[50], size: 28),
            SizedBox(width: 8),
            Text(
              'MovieFinder',
              style: TextStyle(
                color: Colors.teal[50],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.teal[900],
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
  
            },
            icon: Icon(Icons.exit_to_app),
            color: Colors.teal[50],
          ),
            IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen( favoriteActors: actors, favoriteMovies: movies),
                ),
              );
            },
            icon: Icon(Icons.favorite_border),
            color: Colors.teal[50],
          ),
        ],
      ),
      backgroundColor: Colors.teal[50],
      body: ListView(
        children: <Widget>[
          SizedBox(height: 16),
          _buildCategorySection('Top 3 Movies', randomMovies),
          SizedBox(height: 16),
          _buildCategorySection('Recommended Movies', recommendedMovies),
          SizedBox(height: 16),
          _buildCategorySection('New Movies', newMovies),
          SizedBox(height: 16),
          _buildCategorySectionWithDropdown('All Movies', movies),
        ],
      ),
    );
  }

  Widget _buildCategorySection(String title, List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.teal[900],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: movies.map((movie) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieProfileScreen(movie: movie, actors: actors),
                      ),
                    );
                  },

                  child: Container(
                    width: 160,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: Colors.teal[900],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AspectRatio(
                              aspectRatio: 4 / 6,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'lib/assets/images/${movie.photoFilename}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  movie.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.teal[50],
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  movie.genre,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.teal[50],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySectionWithDropdown(String title, List<Movie> movies) {
    List<String> categories =  ['Action', 'Adventure', 'Comedy', 'Crime', 'Drama', 'Fantasy', 'Romance', 'Sci-Fi' ];
    categories.sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.teal[900],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<String>(
                value: _selectedCategory,
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                hint: Text('Select category'),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
          children: movies
                .where((movie) =>
                    _selectedCategory != null &&
                    movie.genre.contains(_selectedCategory!))
                .map((movie) {  
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to movie details page
                  },
                  child: Container(
                    width: 160,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: Colors.teal[900],
                      child: Column(
                        crossAxisAlignment
                        : CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AspectRatio(
                              aspectRatio: 4 / 6,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'lib/assets/images/${movie.photoFilename}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  movie.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.teal[50],
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  movie.genre,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.teal[50],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

