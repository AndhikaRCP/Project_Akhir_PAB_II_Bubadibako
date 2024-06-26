import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/activity_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/detail_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/edit_profile_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/favorite_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/landing_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/profile_screen.dart';
// import 'package:project_akhir_pab_ii_bubadibako/screens/search_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/sign_in_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/sign_up_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/widgets/BottomNavBarWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    await FlutterConfig.loadEnvVariables();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bubadibako',
        theme: theme,
        home: LandingScreen(),
        routes: {
          '/activity': (context) => ActivityScreen(),
          '/detail': (context) => const DetailScreen(),
          '/favorite': (context) => FavoriteScreen(),
          '/landing': (context) => LandingScreen(),
          '/bottomNav': (context) => const BottomNavBarWidget(),
          '/editProfile': (context) => EditProfileScreen(),
          '/profile': (context) => const ProfileScreen(),
          // '/search': (context) => const SearchScreen(),
          '/signIn': (context) => SignInScreen(),
          '/signUp': (context) => SignUpScreen(),
        },
      ),
    );
  }
}
