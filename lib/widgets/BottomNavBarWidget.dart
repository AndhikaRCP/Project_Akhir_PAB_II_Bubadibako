import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/activity_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/favorite_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/notification_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/profile_screen.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({super.key});

  @override
  State<BottomNavBarWidget> createState() => _MyButtomNavBarState();
}

class _MyButtomNavBarState extends State<BottomNavBarWidget> {
  int myCurrentIndex = 0;
  List pages =  [
    ActivityScreen(),
    NotificationScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Bottom Navigation Bar"),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 25,
              offset: const Offset(8, 20))
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
              // backgroundColor: Colors.transparent,
              selectedItemColor: Colors.redAccent,
              unselectedItemColor: Colors.black,
              currentIndex: myCurrentIndex,
              onTap: (index) {
                setState(() {
                  myCurrentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: "Favorite"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Setting"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline), label: "Profile"),
              ]),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}