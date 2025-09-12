// Import the Flutter Material library, which contains all the standard widgets.
import 'package:flutter/material.dart';

// The main function is the starting point for all Flutter apps.
void main(){
  runApp(const SynapseApp());
}

// This is the root widget of the application.
class SynapseApp extends StatelessWidget {
  const SynapseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // We remove the debug banner from the top right corner.
      debugShowCheckedModeBanner: false,
      // We set the entire app's theme to dark to start our space theme.
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A14), // A deep navy blue for our space
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, // Make app bar transparent
          elevation: 0, // Remove shadow
        ),
      ),
      // The home property defines what the user sees on the main screen.
      home: const HomeScreen(),
    );
  }
}

// This widget represents the main screen of our app.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold is a basic page layout widget.
    return Scaffold(
      // AppBar is the bar at the top of the screen.
      appBar: AppBar(
        title: const Text('Synapse'),
      ),
      // Center widget aligns its child (the Text) to the middle of the screen.
      body: const Center(
        child: Text(
          'Our Universe Awaits...',
          style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
