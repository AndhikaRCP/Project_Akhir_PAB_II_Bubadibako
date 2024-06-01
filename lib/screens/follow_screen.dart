import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/userFollower.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/following_screen.dart';
import 'follower_screen.dart';

class FollowScreen extends StatefulWidget {
  const FollowScreen({super.key});

  @override
  State<FollowScreen> createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Follow'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Followers'),
              Tab(text: 'Following'),
            ],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
        body: TabBarView(
          children: [
            FollowerScreen(),
            FollowingScreen(),
          ],
        ),
      ),
    );
  }
}