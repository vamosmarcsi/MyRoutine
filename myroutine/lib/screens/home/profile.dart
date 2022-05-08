import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: myPrimaryLightColor,
      appBar: AppBar(
        backgroundColor: myPrimaryLightColor,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white)),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column( children: [
            Text(
              "Profil",
              style: GoogleFonts.comforter(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white),
            ),
          ],)),
    );
  }
}
