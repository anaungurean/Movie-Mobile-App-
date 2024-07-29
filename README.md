# Movie App

## Overview
The Movie App is a mobile application that allows users to browse through a vast collection of movies. For each movie, users can view detailed information about the plot, actors, and producers. Additionally, users can create and manage their own lists of favorite actors and movies. The app also features a categorization system where movies can be grouped by genre for easier browsing.

This project was developed using Dart and Flutter as part of the "Tehnici de programare pe platforme mobile" course during the final year of university.

## Features
- **Movie Browsing**: Explore a wide range of movies.
- **Movie Details**: Access detailed information for each movie, including plot summaries, actors, and producers.
- **Favorites List**: Create and manage personalized lists of favorite actors and movies.
- **Genre Grouping**: View movies categorized by genre for easy navigation.

## Installation
To get started with the Movie App, follow these steps:

1. **Clone the repository**:
   \`\`\`sh
   git clone https://github.com/anaungurean/movie-app.git
   cd movie-app
   \`\`\`

2. **Install dependencies**:
   \`\`\`sh
   flutter pub get
   \`\`\`

3. **Run the app**:
   \`\`\`sh
   flutter run
   \`\`\`

## Project Structure
The project is organized as follows:
\`\`\`
movie-app/
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── movie_details_screen.dart
│   │   ├── favorites_screen.dart
│   │   └── genre_screen.dart
│   ├── models/
│   │   ├── movie.dart
│   │   ├── actor.dart
│   │   └── genre.dart
│   ├── services/
│   │   ├── movie_service.dart
│   │   ├── actor_service.dart
│   │   └── genre_service.dart
│   ├── widgets/
│   │   ├── movie_card.dart
│   │   ├── actor_card.dart
│   │   └── genre_chip.dart
│   └── utils/
│       ├── constants.dart
│       └── helpers.dart
├── test/
│   ├── widget_test.dart
├── pubspec.yaml
└── README.md
\`\`\`

## Dependencies
- Flutter SDK
- Dart programming language

Refer to \`pubspec.yaml\` for a full list of dependencies.

## How to Use
1. **Browse Movies**: Launch the app and navigate through the collection of movies on the home screen.
2. **View Details**: Tap on any movie to see detailed information about it.
3. **Favorites**: Add movies and actors to your favorites list by tapping the heart icon.
4. **Genres**: Browse movies by genre for easy navigation.
