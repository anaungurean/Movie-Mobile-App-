import 'package:flutter/material.dart';
import 'package:mobile_project/screens/login_screen.dart';
import 'package:mobile_project/screens/movie_screen.dart';
import 'package:mobile_project/shared_preferences_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool? isLoggedIn = await SharedPreferencesHelper.getUserLoggedIn();
  runApp(MyApp(isLoggedIn: isLoggedIn ?? false));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ? MovieScreen() : LoginScreen(),
    );
  }
}
