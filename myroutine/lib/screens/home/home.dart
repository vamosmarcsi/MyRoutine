import 'package:flutter/material.dart';
import 'package:myroutine/models/product.dart';
import 'package:myroutine/screens/home/settings_form.dart';
import 'package:myroutine/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:myroutine/services/database.dart';
import 'package:myroutine/screens/home/product_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    //beállítások
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm()
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.deepPurple[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
              //onpressed is for signing out
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('logout'))
        ],
      ),
    );
   

    /*return StreamProvider<List<Product>>.value(
        value: DatabaseService(uid: '').products,
        initialData: [],
        child: Scaffold(
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
                  icon: Icon(Icons.person, color: Colors.black),
                  label: Text('logout', 
                  style: TextStyle(color: Colors.black))),
              TextButton.icon(
                  onPressed: () => _showSettingsPanel(),
                  icon: Icon(Icons.settings, color: Colors.black),
                  label: Text('settings', style: TextStyle(color: Colors.black)))
            ],
          ),
          body: ProductList(),
        ));*/
  }
}




 
