import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
        leading: const Icon(Icons.menu),
        actions: const [Icon(Icons.search)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Wills liked artwork mother of shells by Nando',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('Image tapped!');
              },
              child: Image.asset(
                'assets/activity/image25.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    print('Add to favorites tapped!');
                  },
                  icon: const Icon(Icons.star),
                ),
                IconButton(
                  onPressed: () {
                    print('Comment tapped!');
                  },
                  icon: const Icon(Icons.comment),
                ),
                IconButton(
                  onPressed: () {
                    // Handle like
                    print('Like tapped!');
                  },
                  icon: const Icon(Icons.favorite),
                ),
                IconButton(
                  onPressed: () {
                    print('More options tapped!');
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Wills liked artwork mother of shells by Nando',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('Image tapped!');
              },
              child: Image.asset(
                'assets/activity/image25.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          _buildBottomNavigationBarItem(Icons.home, 'Home'),
          _buildBottomNavigationBarItem(Icons.upload, 'Upload'),
          _buildBottomNavigationBarItem(Icons.star, 'Favorites'),
          _buildBottomNavigationBarItem(Icons.notifications, 'Notifications'),
          _buildBottomNavigationBarItem(Icons.person, 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.all(10),
        child: Icon(icon, size: 30, color: const Color.fromARGB(255, 0, 0, 0)),
      ),
      label: label,
    );
  }
}
