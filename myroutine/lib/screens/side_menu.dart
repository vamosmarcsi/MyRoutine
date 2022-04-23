import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myroutine/services/auth.dart';
import 'package:myroutine/services/database.dart';
import 'package:myroutine/shared/constants.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(horizontal: 20, vertical: 20);
    final email = AuthService().getEmailAddress() ?? '';
    final uid = AuthService().getUid();
    final db = DatabaseService(uid: uid);
    return Drawer(
      child: Material(
        color: myPrimaryLightColor,
        child: ListView(padding: padding, children: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: myPrimaryColor,
                  ),
                  SizedBox(
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
                                return Text("Something went wrong");
                              }
                              if (snapshot.hasData && !snapshot.data!.exists) {
                                return Text("Document does not exist");
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                Map<String, dynamic> data = snapshot.data!
                                    .data() as Map<String, dynamic>;
                                return Text("${data['name']}",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white));
                              }

                              return Text("loading",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white));
                            },
                          ),
                          const SizedBox(height: 4),
                          Text(email,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white)),
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
                  text: 'Profil', icon: Icons.person, path: '/profile'),
              buildMenuItems(context,
                  text: 'Beállítások', icon: Icons.settings, path: '/settings'),
              buildMenuItems(context,
                  text: 'Varázsló',
                  icon: Icons.person_search_rounded,
                  path: '/wizard'),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }
                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return Text("Document does not exist");
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
