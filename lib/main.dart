import 'package:flutter/material.dart';
import 'Pages/MainScreen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Exo2'),
          bodyMedium: TextStyle(fontFamily: 'Exo2'),
          bodySmall: TextStyle(fontFamily: 'Exo2'),
          displayLarge: TextStyle(fontFamily: 'Exo2'),
          displayMedium: TextStyle(fontFamily: 'Exo2'),
          displaySmall: TextStyle(fontFamily: 'Exo2'),
          headlineLarge: TextStyle(fontFamily: 'Exo2'),
          headlineMedium: TextStyle(fontFamily: 'Exo2'),
          headlineSmall: TextStyle(fontFamily: 'Exo2'),
          titleLarge: TextStyle(fontFamily: 'Exo2'),
          titleMedium: TextStyle(fontFamily: 'Exo2'),
          titleSmall: TextStyle(fontFamily: 'Exo2'),
          labelLarge: TextStyle(fontFamily: 'Exo2'),
          labelMedium: TextStyle(fontFamily: 'Exo2'),
          labelSmall: TextStyle(fontFamily: 'Exo2'),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Exo2',
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      initialRoute: "/MainScreen",
      routes: {
        '/MainScreen': (context) => const MainScreen(),
      },
    );
  }
}
