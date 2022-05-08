import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myroutine/screens/admin/edit_product.dart';
import 'package:myroutine/services/database.dart';
import 'package:myroutine/services/constants.dart';
import '../../services/auth.dart';
import 'package:myroutine/services/storage.dart';

class ProductTile extends StatelessWidget {
  ProductTile({required this.data, required this.id});
  Map<String, dynamic> data;
  String id;

  @override
  Widget build(BuildContext context) {
    final storage = Storage();
    final uid = AuthService().getUid();
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
            margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: FutureBuilder(
              future: storage.downloadProfilePicURL(data["picture"]),
              builder: (context, AsyncSnapshot<String> snapshot) {
                  return ListTile(
                    leading: snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData
                        ? CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                                Image.network(snapshot.data!).image,
                          )
                        : CircleAvatar(
                            radius: 30.0,
                            backgroundColor: myPrimaryColor,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.white70,
                            ),
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
                                MaterialPageRoute(
                                    builder: (context) => EditProduct(),
                                    settings: RouteSettings(arguments: data)),
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
                  );
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  CircularProgressIndicator();
                }
                return Container();
                /*return ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: myPrimaryColor,
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.white70,
                    ),
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
                              MaterialPageRoute(
                                  builder: (context) => EditProduct(),
                                  settings: RouteSettings(arguments: data)),
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
                );*/
              },
            )));
  }
}
