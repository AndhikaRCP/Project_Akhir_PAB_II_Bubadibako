import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:  Text(this.title),
      backgroundColor: Colors.grey,
      automaticallyImplyLeading: false, // Menghilangkan tombol back arrow
      actions: [
        Container(
          margin: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().whenComplete(() {
                Navigator.of(context).pushReplacementNamed("/signIn");
              });
            },
            child: const Text("Logout"),
          ),
        ),
      ],
    );
  }
}
