import 'package:flutter/material.dart';
import 'package:myroutine/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.deepPurple[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
              //onpressed is for signing out
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(Icons.person),
              label: const Text('logout'))
        ],
      ),
    );
  }
}
