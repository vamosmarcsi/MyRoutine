import 'package:flutter/material.dart';
import 'package:myroutine/services/auth.dart';
import 'package:myroutine/shared/constants.dart';
import 'package:myroutine/shared/loading.dart';

class Register extends StatefulWidget {
  //Register({Key? key}) : super(key: key);
  final Function toggleView;
  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  Register({required this.toggleView});

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
            backgroundColor: Colors.deepPurple[200],
            appBar: AppBar(
                backgroundColor: Colors.deepPurple,
                elevation: 0.0,
                title: Text('Sign up'),
                actions: <Widget>[
                  TextButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('Sign In'),
                    onPressed: () {
                      widget.toggleView();
                    },
                  )
                ]),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        validator: (val) => val!.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => pw = val);
                        }),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic res =
                                await _auth.regWithEmailAndPw(email, pw);
                            if (res == null) {
                              setState(
                                  () => err = 'please supply a valid email');
                              loading = false;
                            }
                          }
                        },
                        child: Text('Sign Up',
                            style: TextStyle(color: Colors.deepPurple[200]))),
                    SizedBox(height: 12.0),
                    Text(
                      err,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ]),
                )));
  }
}
