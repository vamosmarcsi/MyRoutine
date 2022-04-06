import 'package:flutter/material.dart';
import 'package:myroutine/services/auth.dart';
import 'package:myroutine/shared/constants.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(horizontal: 20, vertical: 20);
    final email = AuthService().getEmailAddress();
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
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Teszter Eszter',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        const SizedBox(height: 4),
                        Text(email!,
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                      ]),
                ],
              ),
            ),
          ),
          Container(
            padding: padding,
            child: Column(children: [
              const SizedBox(height: 48),
              buildMenuItems(context, text: 'Profil', icon: Icons.people, path: '/profile'),
              buildMenuItems(context, text: 'Beállítások', icon: Icons.people, path: '/settings'),
              buildMenuItems(context, text: 'Varázsló', icon: Icons.people, path: '/wizard')
            ]),
          ),
        ]),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context, {required String text, required IconData icon, required String path}) {
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
