import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/sign_up_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/widgets/edit_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showEditDialog(context);
          },
          child: Text('Edit Profile'),
        ),
      ),
    );
  }
}
