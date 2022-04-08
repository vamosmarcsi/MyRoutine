import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myroutine/screens/authenticate/register.dart';
import 'package:myroutine/screens/authenticate/sign_in.dart';
import 'package:myroutine/shared/constants.dart';

class Welcome extends StatelessWidget {
  //final Function toggleView;
  //Welcome({required this.toggleView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    ...<Widget>[
                      Text(
                        "MyRoutine",
                        style: GoogleFonts.comforter(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: myPrimaryColor),
                      ),
                      SizedBox(height: 20),
                      Text('Szia!\n Jelentkezz be vagy regisztrálj!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15)),
                    ],
                  ],
                ),
                Flexible(child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/roka-ulo.png'))),
                ),),
                Column(
                  children: [
                    ...<Widget>[
                      //login button
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 50,
                        child: Text(
                          "Belépés".toUpperCase(),
                          style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(
                              color: myPrimaryColor,
                            )),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      //reg button
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        child: Text(
                          "Regisztráció".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),),
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        color: myPrimaryColor,
                      ),
                    ]
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
