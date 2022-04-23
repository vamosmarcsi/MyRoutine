import 'package:flutter/material.dart';
import 'package:myroutine/screens/admin/new_product.dart';
import 'package:myroutine/screens/admin/settings_form.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../services/auth.dart';
import '../../services/database.dart';
import '../../shared/constants.dart';
import 'product_list.dart';
import '../side_menu.dart';

class AdminSettings extends StatefulWidget {
  const AdminSettings({Key? key}) : super(key: key);

  @override
  State<AdminSettings> createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final dbService = DatabaseService(uid: _auth.getUid());

    return StreamProvider<List<Product>>.value(
        value: dbService.products,
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
          body: ProductList(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/new-product');
            },
            backgroundColor: myPrimaryColor,
            child: const Icon(Icons.add),
          ),
        ));
  }
}
