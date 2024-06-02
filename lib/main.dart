import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
    import 'package:project_akhir_pab_ii_bubadibako/screens/activity_screen.dart';
    import 'package:project_akhir_pab_ii_bubadibako/screens/detail_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/edit_profile_screen.dart';
    import 'package:project_akhir_pab_ii_bubadibako/screens/favorite_screen.dart';
    import 'package:project_akhir_pab_ii_bubadibako/screens/follower_screen.dart';
    import 'package:project_akhir_pab_ii_bubadibako/screens/following_screen.dart';
    import 'package:project_akhir_pab_ii_bubadibako/screens/landing_screen.dart';
    import 'package:project_akhir_pab_ii_bubadibako/screens/notification_screen.dart';
    import 'package:project_akhir_pab_ii_bubadibako/screens/profile_screen.dart';
    // import 'package:project_akhir_pab_ii_bubadibako/screens/search_screen.dart';
    import 'package:project_akhir_pab_ii_bubadibako/screens/sign_in_screen.dart';
    import 'package:project_akhir_pab_ii_bubadibako/screens/sign_up_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/widgets/BottomNavBarWidget.dart';
    
    

 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
          home: LandingScreen(),
          routes: {
            '/activity': (context) => ActivityScreen(),
            '/detail': (context) => const DetailScreen(),
            '/favorite': (context) => FavoriteScreen(),
            '/follower': (context) => const FollowerScreen(),
            '/following': (context) => const FollowingScreen(),
            '/landing': (context) =>  LandingScreen(),
            '/notification': (context) => const NotificationScreen(),
            '/bottomNav' :(context) =>  const BottomNavBarWidget(),
            '/editProfile' :(context) =>   EditProfileScreen(),
            '/profile': (context) => const ProfileScreen(),
            // '/search': (context) => const SearchScreen(),
            '/signIn': (context) => SignInScreen(),
            '/signUp': (context) => SignUpScreen(),
          },
        );
      }
    }
    