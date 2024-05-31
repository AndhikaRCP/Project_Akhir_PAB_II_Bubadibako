import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/follower.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/activity_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/detail_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/favorite_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/follower_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/following_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/landing_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/notification_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/search_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/sign_in_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/sign_up_screen.dart';

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
      home: const SignUpScreen(),
      routes: {
        '/activity': (context) => const ActivityScreen(),
        '/detail': (context) => const DetailScreen(),
        '/favorite': (context) => const FavoriteScreen(),
        '/follower': (context) => const FollowerScreen(),
        '/following': (context) => const FollowingScreen(),
        '/landing': (context) => const LandingScreen(),
        '/notification': (context) => const LandingScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/search': (context) => const SearchScreen(),
        '/signIn': (context) => const SignInScreen(),
        '/signUp': (context) => const SignUpScreen(),
      },
    );
  }
}
