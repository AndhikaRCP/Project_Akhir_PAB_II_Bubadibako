    import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/dashboard_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/favorite_screen.dart';

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
      home: FavoritesScreen(),
    );
  }
}
