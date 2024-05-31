import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/dashboard_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/activity_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bubadibako',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ActivityScreen(),
    );
  }
}
