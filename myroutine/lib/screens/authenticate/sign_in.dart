import 'package:flutter/material.dart';
import 'package:myroutine/services/auth.dart';
import 'package:myroutine/shared/constants.dart';
import 'package:myroutine/shared/loading.dart';

class SignIn extends StatefulWidget {
  //const SignIn({Key? key}) : super(key: key);

  final Function toggleView;
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

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
            backgroundColor: Colors.deepPurple[200],
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              elevation: 0.0,
              title: const Text('Sign-in'),
              actions: <Widget>[
                TextButton.icon(
                  icon: const Icon(Icons.person),
                  label: const Text('Register'),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 50.0),
                          child: Form(
                            key: _formKey,
                            child: Column(children: <Widget>[
                              const SizedBox(height: 20.0),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Email'),
                                validator: (val) =>
                                    val!.isEmpty ? 'Enter an email' : null,
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Password'),
                                  validator: (val) => val!.length < 6
                                      ? 'Enter a password 6+ chars long'
                                      : null,
                                  obscureText: true,
                                  onChanged: (val) {
                                    setState(() => pw = val);
                                  }),
                              const SizedBox(height: 20.0),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepPurple, // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() => loading = true);
                                      dynamic res = await _auth
                                          .signInWithEmailAndPw(email, pw);
                                      if (res == null) {
                                        setState(() => err =
                                            'could not sign in with those credentials');
                                        loading = false;
                                      }
                                    }
                                  },
                                  child: Text('Sign In',
                                      style: TextStyle(
                                          color: Colors.deepPurple[200])))
                            ]),
                          )),
                    ))
              ],
            ));
  }
}
