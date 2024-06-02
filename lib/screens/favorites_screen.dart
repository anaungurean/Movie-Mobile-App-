import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobile_project/models/actor.dart';
import 'package:mobile_project/models/movie.dart';
import 'package:mobile_project/screens/movieProfile_screen.dart';
import 'package:mobile_project/screens/actorProfile_screen.dart';
import 'package:mobile_project/screens/home_screen.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Movie> favoriteMovies;
  final List<Actor> favoriteActors;

  const FavoritesScreen({
    Key? key,
    required this.favoriteMovies,
    required this.favoriteActors,
  }) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Movie> randomFavoriteMovies = [];
  List<Actor> randomFavoriteActors = [];

  @override
  void initState() {
    super.initState();
    selectRandomFavorites();
  }

  void selectRandomFavorites() {
    setState(() {
      randomFavoriteMovies = getRandomItems(widget.favoriteMovies, 3);
      randomFavoriteActors = getRandomItems(widget.favoriteActors, 3);
    });
  }

  List<T> getRandomItems<T>(List<T> list, int count) {
    list.shuffle();
    return list.take(count).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: TextStyle(color: Colors.teal[50]),
        ),
        backgroundColor: Colors.teal[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.teal[50],

      body: ListView(
        children: [
          _buildSection('Your Favorite Movies', randomFavoriteMovies),
          _buildSection('Your Favorite Actors', randomFavoriteActors),
        ],
      ),
    );
  }

  Widget _buildSection<T>(String title, List<T> items) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal[900]),
          ),
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: items.map((item) {
                if (item is Movie) {
                  return _buildMovieCard(item);
                } else if (item is Actor) {
                  return _buildActorCard(item);
                }
                return SizedBox.shrink();
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.teal[900],
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MovieProfileScreen(movie: movie, actors: []),
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 120,
                height: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'lib/assets/images/${movie.photoFilename}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(
                        color: Colors.teal[50],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      movie.genre,
                      style: TextStyle(
                        color: Colors.teal[50],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActorCard(Actor actor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.teal[900],
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActorProfileScreen(actor: actor),
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 120,
                height: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'lib/assets/images/${actor.photoFilename}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      actor.name,
                      style: TextStyle(
                        color: Colors.teal[50],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
