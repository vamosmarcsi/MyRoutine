import 'package:flutter/material.dart';
import 'package:myroutine/screens/wizard/wizard.dart';
import '../../services/auth.dart';
import '../../services/database.dart';
import '../../services/constants.dart';
class WizardProductTile extends StatefulWidget {
  WizardProductTile({required this.data, required this.id});
  late Map<String, dynamic> data;
  late String id;
  @override
  State<WizardProductTile> createState() => _WizardProductTileState(data: data, id: id);
}

class _WizardProductTileState extends State<WizardProductTile> {
  Map<String, dynamic> data;
  String id;
  Icon icon = Icon(Icons.add_circle);
  bool isChecked = false;
  _WizardProductTileState({required this.data, required this.id});
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
                        setState(() {
                          if(isChecked) {
                            icon = Icon(Icons.add_circle);
                            isChecked = !isChecked;
                          } else {
                            icon = Icon(Icons.check);
                            isChecked = !isChecked;
                          }
                        });
                      },
                      icon: icon),
                ],
              ),
            )));
  }
}


/*class WizardProductTile extends StatelessWidget {
  WizardProductTile({required this.data, required this.id});
  Map<String, dynamic> data;
  String id;
  Icon icon = Icon(Icons.add_circle);

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
                         icon = Icon(Icons.check);
                      },
                      icon: icon),
                ],
              ),
            )));
  }
}*/
