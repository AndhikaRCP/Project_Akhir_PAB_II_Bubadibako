import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Wills liked artwork mother of shells by Nando',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                // Handle tap on the image
                print('Image tapped!');
              },
              child: Image.asset(
                'assets/activity/image25.png', // Replace with your actual image asset
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    // Handle add to favorites
                    print('Add to favorites tapped!');
                  },
                  icon: const Icon(Icons.star),
                ),
                IconButton(
                  onPressed: () {
                    // Handle comment
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
                    // Handle more options
                    print('More options tapped!');
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Wills liked artwork mother of shells by Nando',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                // Handle tap on the image
                print('Image tapped!');
              },
              child: Image.asset(
                'assets/activity/image25.png', // Replace with your actual image asset
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'AQUABLUE',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
