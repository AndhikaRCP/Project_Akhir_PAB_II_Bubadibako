import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/dashboard_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/activity_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          theme: themeProvider.themeData,
          home: ActivityScreen(),
        );
      },
    );
  }
}
