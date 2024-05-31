import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/data/list_notification.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/detailnotifikasi_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
    int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final notification = listNotification[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailNotifikasi(notification: notification),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.black38, width: 1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.judul,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    notification.deskripsiNotifikasi,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: listNotification.length,
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
