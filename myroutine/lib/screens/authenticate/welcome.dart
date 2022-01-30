import 'package:flutter/material.dart';
import 'package:myroutine/shared/constants.dart';

class Welcome extends StatelessWidget {
  final Function toggleView;
  Welcome({required this.toggleView});

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
                    "Szia!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: myPrimaryColor),
                  ),
                  SizedBox(height: 20),
                  Text('Jelentkezz be vagy regisztrálj!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15)),
                ],
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/roka-ulo.png'))),
            ),
            Column(
              children: [
                ...<Widget>[
                  //login button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
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
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //reg button
                  Container(
                      padding: EdgeInsets.only(top: 3.0, left: 3.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                            bottom: BorderSide(color: myPrimaryColor),
                            top: BorderSide(color: myPrimaryColor),
                            left: BorderSide(color: myPrimaryColor),
                            right: BorderSide(color: myPrimaryColor)),
                      ),
                      child: MaterialButton(
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
                          borderRadius: BorderRadius.circular(50),
                        ),
                        onPressed: () {},
                        color: myPrimaryColor,
                        elevation: 0,
                      )),
                ]
              ],
            )
          ],
        ),
      ),
    ));
  }
}
