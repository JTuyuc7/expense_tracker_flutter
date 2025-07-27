import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepPurple,
  primary: Colors.purple,
  secondary: Colors.deepOrange,
);

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepPurple,
  brightness: Brightness.dark,
  primary: Colors.purple,
  secondary: Colors.deepOrange,
);

var kAppBarTheme = const AppBarTheme().copyWith(
  backgroundColor: Colors.purple,
  foregroundColor: Colors.white,
  centerTitle: true,
);

var kCardTheme = const CardThemeData().copyWith(
  // color: Colors.white,
  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // WidgetsFlutterBinding.ensureInitialized();
    // SystemChrome.setPreferredOrientations([
    //   // DeviceOrientation.portraitUp,
    //   // DeviceOrientation.portraitDown,
    // ]).then( (fn) {
    //   //* Add the run app here, so that the app runs only in portrait mode
    // });
    return MaterialApp(
      title: 'Expense Tracker',
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        appBarTheme: kAppBarTheme,
        scaffoldBackgroundColor: Colors.grey[900],
        cardTheme: kCardTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: kAppBarTheme,
        scaffoldBackgroundColor: Colors.grey[200],
        cardTheme: kCardTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        textTheme: const TextTheme().copyWith(
          titleLarge: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyLarge: const TextStyle(fontSize: 16, color: Colors.black),
          bodyMedium: const TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 131, 130, 130),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    );
  }
}
