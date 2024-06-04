import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/auth_services.dart'; // Import the DashboardScreen

class LandingScreen extends StatefulWidget {
  LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/image/logo.png',
              height: 200,
              width: 180,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'BUBADIBAKO',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'LuckiestGuy',
                color: Color.fromARGB(255, 255, 255, 255),
                shadows: [
                  Shadow(
                    offset: Offset(3.0, 3.0),
                    blurRadius: 0.0,
                    color: Colors.black,
                  ),
                  Shadow(
                    offset: Offset(-3.0, -3.0),
                    blurRadius: 0.0,
                    color: Colors.black,
                  ),
                  Shadow(
                    offset: Offset(3.0, -3.0),
                    blurRadius: 0.0,
                    color: Colors.black,
                  ),
                  Shadow(
                    offset: Offset(-3.0, 3.0),
                    blurRadius: 0.0,
                    color: Colors.black,
                  ),
                  Shadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    color: Colors.white,
                  ),
                ],
                letterSpacing: 7.0,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/signIn');
              },
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/signUp');
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
