import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<NotificationItem> notifications = [
    NotificationItem(
        'Richie Pakusalam', 'comment your post', 'about 5 hours ago'),
    NotificationItem('Zaky Jonathan Simanjuntak', 'comment likes your post',
        'about 17 hours ago'),
    NotificationItem('Andhika Tanuwijaya Sitohang', 'comment likes your post',
        'about 1 day ago'),
    NotificationItem(
        'Cristopher Rajaguguk', 'comment your post', 'about 2 days ago'),
    NotificationItem(
        'Williskuy Wala Wala', 'comment your post', 'about 3 days ago'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.account_circle, size: 40),
            title: Text(notifications[index].user),
            subtitle: Text(notifications[index].action),
            trailing: Text(notifications[index].timeElapsed),
          );
        },
      ),
    );
  }
}

class NotificationItem {
  final String user;
  final String action;
  final String timeElapsed;

  NotificationItem(this.user, this.action, this.timeElapsed);
}
