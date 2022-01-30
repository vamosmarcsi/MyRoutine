import 'package:flutter/material.dart';
import 'package:myroutine/enums/skin_problems.dart';
import 'package:myroutine/enums/skin_types.dart';
import 'package:myroutine/models/myuser.dart';
import 'package:myroutine/services/database.dart';
import 'package:myroutine/shared/constants.dart';
import 'package:myroutine/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  SkinProblems? _currentSkinProblem;
  SkinType? _currentSkinType;
  final List<String> skinProbs = ['pattanások', 'mitesszerek', 'száraz bőr'];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Text(
                  'Beállítások',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                //beviteli mező
                TextFormField(
                  initialValue: userData?.skinType.toString(),
                  decoration: textInputDecoration,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentSkinType = val as SkinType?),
                ),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  items: skinProbs.map((p) {
                    return DropdownMenuItem(
                      value: p,
                      child: Text(p),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() => _currentSkinProblem = val.toString() as SkinProblems?);
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSkinProblem ?? SkinProblems.notSpecified,
                            _currentSkinType ?? SkinType.notSpecified);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Update')),
              ]),
            );
          } else {
            return const Loading();
          }
        });
  }
}