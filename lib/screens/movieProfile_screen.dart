import 'package:flutter/material.dart';
import 'package:mobile_project/models/movie.dart';
import 'package:mobile_project/database_helper.dart';
import 'actorProfile_screen.dart';
import 'package:mobile_project/models/actor.dart';
import 'dart:math'; // Add this import for generating random numbers

class MovieProfileScreen extends StatefulWidget {
  final Movie movie;
  final List<Actor> actors;

  const MovieProfileScreen({
    required this.movie,
    required this.actors,
  });

  @override
  _MovieProfileScreenState createState() => _MovieProfileScreenState();
}

class _MovieProfileScreenState extends State<MovieProfileScreen> {
  bool isFavorite = false;
  late int rating; // Declare a variable to hold the random rating

  @override
  void initState() {
    super.initState();
    // Initialize the rating with a random value between 3 and 5
    rating = 3 + Random().nextInt(3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie.title,
          style: TextStyle(color: Colors.teal[50]),
        ),
        backgroundColor: Colors.teal[900],
          actions: [
          IconButton(
            onPressed: () => {
              if (!isFavorite)
                {
                  setState(() {
                    isFavorite = true;
                  }),
                }
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_outline,
            ),
            // Culoarea iconiței
            color: isFavorite ? Colors.teal[50] : Colors.teal[50],
          ),
        ],
      ),
      backgroundColor: Colors.teal[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  // Wrap the Container in a Column
                  children: [
                    Container(
                      width: 200,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage(
                              'lib/assets/images/${widget.movie.photoFilename}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                        height:
                            8), // Add spacing between the image and the rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(rating, (index) {
                        return Icon(
                          Icons.star,
                          color: Colors.teal[900],
                          size: 30.0,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Colors.teal[100],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(
                          widget.movie.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center, // Centrare butoane
                          spacing: 8,
                          runSpacing: 4,
                          children: widget.movie.genre.split(',').map((genre) {
                            return ElevatedButton(
                              onPressed:
                                  () {}, // Aici poți adăuga logica pentru buton dacă este necesară
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .teal[900], // Culoarea fundalului butonului
                              ),
                              child: Text(
                                genre.trim(),
                                style: TextStyle(
                                  color: Colors
                                      .teal[50], // Culoarea textului butonului
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Text(
                          widget.movie.plot,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'Director: ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.movie.director,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Release Date: ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.movie.releaseDate,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Actors: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        children: widget.movie.actors.map((actor) {
                          return GestureDetector(
                            onTap: () {
                              // Navigare către pagina actorului când este apăsat Chip-ul
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ActorProfileScreen(
                                      actor: widget.actors.firstWhere(
                                          (element) => element.name == actor)),
                                ),
                              );
                            },
                            child: Chip(
                              label: Text(
                                actor,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal[50],
                                ),
                              ),
                              labelStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[50],
                              ),
                              backgroundColor: Colors.teal[900],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
