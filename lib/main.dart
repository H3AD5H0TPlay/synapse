import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

Future<void> main() async {
  // This initialization is best practice to ensure all bindings are ready.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SynapseApp());
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Synapse'),
      ),
      body: const ModelViewer(
        backgroundColor: Color(0xFF0A0A14),
        src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
        alt: "A 3D model of our first Synapse node",
        ar: true,
        autoRotate: true,
        cameraControls: true,
      ),
    );
  }
}

