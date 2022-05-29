import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:myroutine/services/auth.dart';
import 'package:myroutine/services/database.dart';
import 'package:myroutine/services/constants.dart';
import 'package:myroutine/services/storage.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 20, vertical: 20);
    final email = AuthService().getEmailAddress() ?? '';
    final uid = AuthService().getUid();
    final db = DatabaseService(uid: uid);
    final storage = Storage();
    String picName = "";
    return Drawer(
      child: Material(
        color: myPrimaryLightColor,
        child: ListView(padding: padding, children: <Widget>[
          InkWell(
            child: Container(
              padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
              child: Row(
                children: <Widget>[
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Something went wrong");
                      }
                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return const Text("Document does not exist");
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        picName = data['profile_pic'].toString();
                        if (data["profile_pic"] != null) {
                          return FutureBuilder(
                            future: storage.downloadProfilePicURL(picName),
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  !data["profile_pic"].isEmpty) {
                                return CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: myPrimaryColor,
                                  backgroundImage:
                                      Image.network(snapshot.data!).image,
                                );
                              }
                              if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                  !snapshot.hasData) {
                                return const CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: myPrimaryColor,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white70,
                                  ),
                                );
                              }
                              //print(picName);
                              return const CircleAvatar(
                                radius: 30.0,
                                backgroundColor: myPrimaryColor,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white70,
                                ),
                              );
                            },
                          );
                        }
                      }
                      return const CircleAvatar(
                        radius: 30.0,
                        backgroundColor: myPrimaryColor,
                        child: Icon(
                          Icons.person,
                          color: Colors.white70,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text("Something went wrong");
                              }
                              if (snapshot.hasData && !snapshot.data!.exists) {
                                return const Text("Document does not exist");
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                Map<String, dynamic> data = snapshot.data!
                                    .data() as Map<String, dynamic>;
                                return Text("${data['name']}",
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white));
                              }

                              return const Text("loading",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white));
                            },
                          ),
                          const SizedBox(height: 4),
                          Text(email,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white)),
                        ]),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: padding,
            child: Column(children: [
              const SizedBox(height: 48),
              buildMenuItems(context,
                  text: 'Rutinom', icon: Icons.list, path: '/home'),
              buildMenuItems(context,
                  text: 'Profil', icon: Icons.person, path: '/profile'),
              buildMenuItems(context,
                  text: 'Kalauz', icon: Icons.help_outline, path: '/help'),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Valami hiba történt...");
                  }
                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return const Text("Nem létező dokumentum...");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    if(data['isAdmin']) {
                      return buildMenuItems(context,
                          text:
                          'Adatbázis kezelése',
                          icon: Icons.edit,
                          path: '/admin');
                    }
                  }
                  return Container();
                },
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context,
      {required String text, required IconData icon, required String path}) {
    final color = Colors.white;
    final hoverColor = Colors.white70;
    return ListTile(
        leading: Icon(icon, color: color),
        title: Text(text, style: TextStyle(color: color)),
        hoverColor: hoverColor,
        onTap: () {
          Navigator.pushNamed(context, path);
        });
  }
}
