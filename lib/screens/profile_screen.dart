// main.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 0;
  // This function show the sliver app bar
  // It will be called in each child of the TabBarView
  SliverAppBar showSliverAppBar(String screenTitle) {
  return SliverAppBar(
    backgroundColor: Colors.purple,
    floating: true,
    pinned: true,
    snap: false,
    flexibleSpace: FlexibleSpaceBar(
      title: Text(screenTitle),
      background: Column(
        children: [
          Stack(
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1536152470836-b943b246224c?q=80&w=1938&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              const Positioned(
                bottom: 10,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "dika",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '12 Follower',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '23 Following',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            color: Colors.green,
            width: 100,
            height: 100,
          )
        ],
      ),
    ),
    bottom: const TabBar(
      tabs: [
        Tab(
          icon: Icon(Icons.home),
          text: 'Home',
        ),
        Tab(
          icon: Icon(Icons.settings),
          text: 'Setting',
        )
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" INI ADLAAH JUDUL"
        ),
      ),
        body: DefaultTabController(
      length: 2,
      child: TabBarView(children: [
        // This CustomScrollView display the Home tab content
        CustomScrollView(
          slivers: [
            showSliverAppBar('Kindacode Home'),
  
            // Anther sliver widget: SliverList
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(
                  height: 400,
                  child: Center(
                    child: Text(
                      'Home Tab',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                Container(
                  height: 1500,
                  color: Colors.green,
                ),
              ]),
            ),
          ],
        ),

        // This shows the Settings tab content
        CustomScrollView(
          slivers: [
            showSliverAppBar('Settings Screen'),

            // Show other sliver stuff
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: 600,
                  color: Colors.blue[200],
                  child: const Center(
                    child: Text(
                      'Setting Tab',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                Container(
                  height: 1200,
                  color: Colors.pink,
                ),
              ]),
            ),
          ],
        )
      ]),
    ),
    bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          _buildBottomNavigationBarItem(Icons.home, 'activity', '/activity'),
          _buildBottomNavigationBarItem(Icons.upload, 'upload', '/upload'),
          _buildBottomNavigationBarItem(Icons.star, 'favorite','/favorite'),
          _buildBottomNavigationBarItem(Icons.notifications, 'notification','/notification'),
          _buildBottomNavigationBarItem(Icons.person, 'profile','/profile'),
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
      IconData icon, String label, String route) {
    return BottomNavigationBarItem(
      icon: InkWell(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Icon(icon, size: 30, color: const Color.fromARGB(255, 0, 0, 0)),
        ),
        onTap: () => Navigator.of(context).pushNamed(route),
      ),
      label: label,
    );
  }
}