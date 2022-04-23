import 'package:flutter/material.dart';
import 'package:myroutine/screens/admin/edit_product.dart';
import 'package:myroutine/services/database.dart';
import 'package:myroutine/shared/constants.dart';
import '../../services/auth.dart';

class ProductTile extends StatelessWidget {
  ProductTile({required this.data, required this.id});
  Map<String, dynamic> data;
  String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
            margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: myPrimaryColor,
              ),
              title: Text(data['name']),
              subtitle: Text(data['brand']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        DatabaseService(uid: AuthService().getUid())
                            .updateID(id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditProduct(),
                            settings: RouteSettings(
                              arguments: data
                            )
                          ),
                        );
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        DatabaseService(uid: AuthService().getUid())
                            .deleteProduct(id);
                      },
                      icon: Icon(Icons.delete)),
                ],
              ),
            )));
  }
}
