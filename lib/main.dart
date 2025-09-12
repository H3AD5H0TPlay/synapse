import 'dart:math'; // Import the math library for the Random() function.

import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

Future<void> main() async {
  // This initialization is best practice to ensure all bindings are ready.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SynapseApp());
}

// UPDATED: The Node class now holds its own position.
class Node {
  final String src;
  final double x; // X position (0.0 to 1.0)
  final double y; // Y position (0.0 to 1.0)

  Node({required this.src, required this.x, required this.y});
}

class SynapseApp extends StatelessWidget {
  const SynapseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A14),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This list now holds nodes with positions.
  final List<Node> _nodes = [
    // The first node starts in the center of the screen.
    Node(
      src: 'https://modelviewer.dev/shared-assets/models/sphere.glb',
      x: 0.5,
      y: 0.5,
    ),
  ];

  // A function to add a new node at a random position.
  void _addNode() {
    final random = Random();
    setState(() {
      _nodes.add(
        Node(
          src: 'https://modelviewer.dev/shared-assets/models/sphere.glb',
          // Generate a random double between 0.0 and 1.0 for the position.
          x: random.nextDouble(),
          y: random.nextDouble(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Synapse'),
      ),
      body: Stack(
        children: [
          // We loop through our list of nodes and position each one.
          ..._nodes.map((node) {
            // UPDATED: Use the Align widget to position our nodes.
            return Align(
              // The alignment is calculated from our 0.0-1.0 coordinates.
              // This maps our simple coordinates to the widget's internal alignment system.
              alignment: Alignment((node.x * 2) - 1, (node.y * 2) - 1),
              // We wrap the ModelViewer in a SizedBox to give it a specific size.
              child: SizedBox(
                width: 200,
                height: 200,
                child: ModelViewer(
                  backgroundColor: Colors.transparent, // Transparent background
                  src: node.src,
                  alt: "A 3D model of a Synapse node",
                  ar: true,
                  autoRotate: true,
                  cameraControls: true,
                  shadowIntensity: 1,
                  cameraOrbit: "0deg 75deg 105%",
                ),
              ),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNode,
        child: const Icon(Icons.add),
      ),
    );
  }
}

