import 'package:flutter/material.dart';
import 'package:mobile_project/models/movie.dart';

class MovieProfileScreen extends StatelessWidget {
  final Movie movie;

  const MovieProfileScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.teal[50]),
        ),
        backgroundColor: Colors.teal[900],
      ),
        backgroundColor: Colors.teal[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color:Colors.teal[100],  
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(
                          movie.title,
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
                          children: movie.genre.split(',').map((genre) {
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
                          movie.plot,
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
                            movie.director,
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
                            movie.releaseDate,
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
                        children: movie.actors.map((actor) {
                          return Chip(
                            label: Text(
                              actor,
                              style: TextStyle(
                                fontSize:
                                    14, // specifică dimensiunea fontului dorită
                                fontWeight: FontWeight
                                    .bold, // specifică grosimea fontului
                                color:
                                    Colors.teal[50], // specifică culoarea textului
                              ),
                            ),
                            labelStyle: TextStyle(
                              // aici poți specifica stilul pentru etichetă
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal[50],
                            ),
                              backgroundColor: Colors
                                .teal[900], // setează culoarea de fundal a chipului
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
