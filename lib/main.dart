import 'dart:math';

import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
// A package to generate unique IDs for our nodes.
import 'package:uuid/uuid.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SynapseApp());
}

// A helper for generating unique IDs
const uuid = Uuid();

// UPDATED: The Node class now has a unique ID.
class Node {
  final String id;
  final String src;
  double x; // Position is no longer final, as it will be updated.
  double y;

  Node({required this.id, required this.src, required this.x, required this.y});
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
  final List<Node> _nodes = [
    Node(
      id: uuid.v4(), // Assign a unique ID to the first node.
      src: 'https://modelviewer.dev/shared-assets/models/sphere.glb',
      x: 0.5,
      y: 0.5,
    ),
  ];

  // NEW: State variable to track the ID of the node being dragged.
  String? _draggedNodeId;

  void _addNode() {
    final random = Random();
    setState(() {
      _nodes.add(
        Node(
          id: uuid.v4(), // Assign a unique ID to new nodes.
          src: 'https://modelviewer.dev/shared-assets/models/sphere.glb',
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
          ..._nodes.map((node) {
            return Align(
              alignment: Alignment((node.x * 2) - 1, (node.y * 2) - 1),
              // NEW: Wrap the node in a GestureDetector to make it interactive.
              child: GestureDetector(
                // When the user starts dragging...
                onPanStart: (details) {
                  setState(() {
                    _draggedNodeId = node.id;
                  });
                },
                // As the user drags...
                onPanUpdate: (details) {
                  // If we are dragging a node...
                  if (_draggedNodeId == node.id) {
                    setState(() {
                      // Update its position based on the drag delta.
                      // We divide by the screen width/height to normalize the value between 0.0 and 1.0.
                      node.x += details.delta.dx / context.size!.width;
                      node.y += details.delta.dy / context.size!.height;
                    });
                  }
                },
                // When the user stops dragging...
                onPanEnd: (details) {
                  setState(() {
                    _draggedNodeId = null;
                  });
                },
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: ModelViewer(
                    backgroundColor: Colors.transparent,
                    src: node.src,
                    alt: "A 3D model of a Synapse node",
                    ar: true,
                    // UPDATED: Make the node rotate on its own, but stop when dragged.
                    autoRotate: _draggedNodeId != node.id,
                    // NEW: Control the speed of the rotation to be slower.
                    rotationPerSecond: '20deg',
                    cameraControls: false,
                    shadowIntensity: 1,
                  ),
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

