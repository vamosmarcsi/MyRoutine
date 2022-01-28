import 'package:flutter/material.dart';
import 'package:myroutine/models/myuser.dart';
import 'package:myroutine/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';
import 'package:myroutine/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    //return either Home or Authenticate widget
    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}