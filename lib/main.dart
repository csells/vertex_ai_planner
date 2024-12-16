import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _model = FirebaseVertexAI.instance.generativeModel(
    model: 'gemini-1.5-flash-002',
    systemInstruction: Content.text('TODO'),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Vertex AI Planner!')),
        body: const Text('TODO'),
      );
}
