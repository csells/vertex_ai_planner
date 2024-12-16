import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'data/plan_repository.dart';
import 'firebase_options.dart';
import 'split_or_tabs.dart';
import 'views/planner_view.dart';
import 'views/plans_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: HomePage()));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final planRepository = PlanRepository();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Vertex AI Planner')),
      body: SplitOrTabs(
        tabs: const [
          Tab(text: 'Planner'),
          Tab(text: 'Plans'),
        ],
        children: [
          PlannerView(planRepository: planRepository),
          PlansView(planRepository: planRepository),
        ],
      ),
    );
  }
}
