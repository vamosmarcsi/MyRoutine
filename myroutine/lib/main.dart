import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myroutine/screens/wrapper.dart';
import 'models/myuser.dart';
import 'package:provider/provider.dart';
import 'package:myroutine/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
        catchError: (_, __) => null,
      value: AuthService().user,
      initialData: null,
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

