import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myroutine/shared/constants.dart';

class Wizard extends StatefulWidget {
  const Wizard({Key? key}) : super(key: key);

  @override
  State<Wizard> createState() => _WizardState();
}

class _WizardState extends State<Wizard> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String current = '';
    List<String>? skinProbs = ['wrinkles',
      'acne',
      'blackheadsOrBigPores',
      'pimples',
      'eczema',
      'rosacea',
      'pigmentsSpots',
      'notSpecified'];
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: <Widget>[
                  Text(
                    "Varázsló",
                    style: GoogleFonts.comforter(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Container(
                          child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Bőrprobléma',
                                  prefixIcon:
                                      Icon(Icons.email, color: myPrimaryColor)),
                            ),
                            /*DropdownButtonFormField(
                              value: current,
                              decoration: textInputDecoration,
                              items: skinProbs.map((skinProb) {
                                return DropdownMenuItem<String>(
                                  value: skinProb,
                                  child: Text('$skinProb skinProb'),
                                );
                              }).toList(),
                              onChanged: (val) => {}
                            )*/
                          ],
                        ),
                      ))
                    ],
                  ))
            ],
          )),
    );
  }
}
