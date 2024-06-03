import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      backgroundColor: Colors.grey,
      automaticallyImplyLeading: false,
      actions: [
         Switch.adaptive(
          value: AdaptiveTheme.of(context).mode.isDark,
          onChanged: (state) {
            AdaptiveTheme.of(context).toggleThemeMode(useSystem: false);
          },
          activeTrackColor: Colors.grey[300],

        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().whenComplete(() {

                //////back to white again
                AdaptiveTheme.of(context).reset(); //
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
