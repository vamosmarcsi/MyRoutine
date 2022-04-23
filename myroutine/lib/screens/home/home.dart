import 'package:flutter/material.dart';
import 'package:myroutine/models/product.dart';
import 'package:myroutine/screens/admin/settings_form.dart';
import 'package:myroutine/services/auth.dart';
import 'package:myroutine/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:myroutine/services/database.dart';
import 'package:myroutine/screens//side_menu.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final padding = EdgeInsets.symmetric(horizontal: 20);
  bool loading = false;
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

    return StreamProvider<List<Product>>.value(
        value: DatabaseService(uid: _auth.getUid()).products,
        initialData: [],
        child: Scaffold(
          drawer: SideMenu(),
          backgroundColor: myPrimaryLightColor,
          appBar: AppBar(
            backgroundColor: myPrimaryColor,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.pushNamed(context, '/welcome');
                  },
                  icon: Icon(Icons.logout, color: Colors.white),
                  ),
            ],
          ),
          body: Container(),
        ));
  }
}
