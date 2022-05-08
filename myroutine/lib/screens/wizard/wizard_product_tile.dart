import 'package:flutter/material.dart';
import '../../services/auth.dart';
import '../../services/database.dart';
import '../../services/constants.dart';
class WizardProductTile extends StatelessWidget {
  WizardProductTile({required this.data, required this.id});
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

                      },
                      icon: Icon(Icons.add_circle)),
                ],
              ),
            )));
  }
}
