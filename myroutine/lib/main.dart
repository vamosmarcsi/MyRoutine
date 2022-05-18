import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:myroutine/screens/admin/admin_settings.dart';
import 'package:myroutine/screens/admin/new_product.dart';
import 'package:myroutine/screens/authenticate/register.dart';
import 'package:myroutine/screens/authenticate/sign_in.dart';
import 'package:myroutine/screens/authenticate/welcome.dart';
import 'package:myroutine/screens/home/home.dart';
import 'package:myroutine/screens/home/profile.dart';
import 'package:myroutine/screens/home/settings.dart';
import 'package:myroutine/screens/wizard/wizard.dart';
import 'models/myuser.dart';
import 'package:provider/provider.dart';
import 'package:myroutine/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      catchError: (_, __) => null,
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/welcome',
        routes: {
          '/home': (context) => const Home(),
          '/register': (context) => Register(),
          '/login': (context) => const SignIn(),
          '/welcome': (context) => Welcome(),
          '/settings': (context) => const Settings(),
          '/profile': (context) => const Profile(),
          '/wizard': (context) => Wizard(),
          '/admin': (context) => const AdminSettings(),
          '/new-product': (context) => NewProduct(),
        },
      ),
    );
  }
}
