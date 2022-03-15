import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myroutine/services/auth.dart';
import 'package:myroutine/shared/constants.dart';
import 'package:myroutine/shared/loading.dart';

class Register extends StatefulWidget {
  //Register({Key? key}) : super(key: key);
  //final Function toggleView;
  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  //Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String pw = '';
  String err = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[100],
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
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
                      "Regisztráció",
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
                              SizedBox(height: 20.0),
                              TextFormField(
                                decoration:
                                textInputDecoration.copyWith(hintText: 'Email cím',
                                    prefixIcon: Icon(Icons.email, color: myPrimaryColor)),
                                validator: (val) =>
                                val!.isEmpty ? 'Kérlek, add meg az email címed!' : null,
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                  decoration:
                                  textInputDecoration.copyWith(hintText: 'Jelszó',
                                      prefixIcon: Icon(Icons.key, color: myPrimaryColor)
                                  ),
                                  validator: (val) => val!.length < 6
                                      ? 'A jelszó legalább 6 karakterból állhat.'
                                      : null,
                                  obscureText: true,
                                  onChanged: (val) {
                                    setState(() => pw = val);
                                  }),
                              SizedBox(height: 20.0),
                              MaterialButton(
                                  minWidth: double.infinity,
                                  height: 60,
                                  color: myPrimaryColor,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      //setState(() => loading = true);
                                      dynamic res =
                                      await _auth.regWithEmailAndPw(email, pw);
                                      if (res == null) {
                                        setState(
                                                () => err = 'Érvényes email címet adj meg!');
                                        //loading = false;
                                      } else {
                                        //TODO varázslóra ugrani
                                        Navigator.pushNamed(context,'/home');
                                      }
                                    }
                                  },
                                  child: Text('Regisztrálok'.toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.white))),
                              SizedBox(height: 5.0),
                              Text(
                                err,
                                style: TextStyle(color: Colors.red, fontSize: 14.0),
                              )
                            ]),
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/roka-pitypang.png'),
                        fit: BoxFit.cover,
                      )),
                ),
              ]
          ),
        ));
  }
}

//TODO a vissza gomb routing-ot javítani, vagy csinálni egy linket a toggle-höz
