import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/image/logo.png'),
            const SizedBox(height: 32.0),
            const Text(
              'Bubadibako',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'LuckiestGuy',
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
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
          ],
        ),
      ),
    );
  }
}
