import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Profile Screen"),
        backgroundColor: Colors.grey,
        actions: [
          Container(
            child: ElevatedButton(onPressed: () {}, child: Text("Logout")),
            margin: EdgeInsets.all(10.0),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                    "https://images.unsplash.com/photo-1714779573259-216b0cf746be?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                Positioned(
                  left: 15,
                  bottom: 15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0), //or 15.0
                    child: Container(
                      height: 90.0,
                      width: 90.0,
                      color: Color(0xffFF0E58),
                      child: Image.network(
                          fit: BoxFit.cover,
                          "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.green,
              height: 50,
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    child: Text(""),
                    onPressed: () {},
                  )),
                  Expanded(
                      child: Text(
                    "About",
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
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
