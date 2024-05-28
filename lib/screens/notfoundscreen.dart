import 'package:flutter/material.dart';

class NotFoundScreen extends StatefulWidget {
  const NotFoundScreen({super.key});

  @override
  State<NotFoundScreen> createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '404',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'LuckiestGuy',
                      fontSize: 72.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                      ],
                    ),
                  ),
                  Text(
                    'NOT FOUND',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'LuckiestGuy',
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Image.asset(
              'assets/image/notfound.png',
            ),
          ),
        ],
      ),
    );
  }
}
