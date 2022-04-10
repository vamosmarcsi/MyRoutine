import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myroutine/services/auth.dart';
import 'package:myroutine/shared/constants.dart';
import 'package:myroutine/shared/loading.dart';

class SignIn extends StatefulWidget {
  //const SignIn({Key? key}) : super(key: key);

  //final Function toggleView;
  const SignIn({Key? key,  /*required this.toggleView*/}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String pw = '';
  String err = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[100],
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/welcome');
              },
              icon: Icon(Icons.arrow_back_ios,
                  size: 20, color: Colors.black)),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Bejelentkezés",
                      style: GoogleFonts.comforter(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: myPrimaryColor),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      Container(
                          child: Form(
                            key: _formKey,
                            child: Column(children: <Widget>[
                              const SizedBox(height: 20.0),
                              //email
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Email cím',
                                    prefixIcon: Icon(Icons.email, color: myPrimaryColor)
                                ),
                                validator: (val) => val!.isEmpty
                                    ? 'Kérlek, add meg az email címed!'
                                    : null,
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                              ),
                              const SizedBox(height: 20.0),
                              //jelszó
                              TextFormField(
                                  cursorColor: myPrimaryLightColor,
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Jelszó',
                                      prefixIcon: Icon(Icons.key, color: myPrimaryColor)
                                  ),
                                  validator: (val) => val!.length < 6
                                      ? 'A jelszó legalább 6 karakterból állhat.'
                                      : null,
                                  obscureText: true,
                                  onChanged: (val) {
                                    setState(() => pw = val);
                                  }),
                              const SizedBox(height: 20.0),
                              //bejelentkezés gomb
                              MaterialButton(
                                  minWidth: double.infinity,
                                  height: 60,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  color: myPrimaryColor,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      //setState(() => loading = true);
                                      dynamic res = await _auth
                                          .signInWithEmailAndPw(email, pw);
                                      Navigator.pushNamed(context, '/home');
                                      print("navigator to home");
                                      if (res == null) {
                                        setState(() => err =
                                        'Nem sikerült a bejelentkezés!');
                                        //loading = false;
                                      }
                                    }
                                  },
                                  child: Text('Bejelentkezek'.toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.white)))
                            ]),
                          ))
                    ],
                  ),
                ),
                Flexible(child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/roka-kave.png'),
                        fit: BoxFit.cover,
                      )),),
                ),
              ],
            )));
  }
}
