import 'package:flutter/material.dart';

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
