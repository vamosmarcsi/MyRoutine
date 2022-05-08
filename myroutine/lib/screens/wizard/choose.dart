import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myroutine/services/constants.dart';

class Choose extends StatefulWidget {
  const Choose({Key? key}) : super(key: key);

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  final _formKey = GlobalKey<FormState>();
  final _currentVal = TextEditingController();

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
          child: Column(
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
                                  blank,
                                  Text(
                                    "Szeretnéd, ha javasolnánk neked termékeket, vagy te szeretnéd összeállítani a rutinod?",
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                  DropdownButtonFormField<String>(
                                    decoration: textInputDecoration,
                                    hint: Text("Válassz!"),
                                    items: ["Igen", "Nem, magam rakom össze!"].map((item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() => _currentVal.text = val.toString());
                                    },
                                  ),
                                  /*blank,
                            Text(
                              "Szeretnéd, ha értesítéseket küldenénk neked?",
                              textAlign: TextAlign.center,
                              style:
                              TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            DropdownButtonFormField<String>(
                              decoration: textInputDecoration,
                              hint: Text("Válassz!"),
                              //value: data["category"],
                              items: ["Igen", "Nem"].map((item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if(val == "Igen")
                                  setState(() => notification = true);
                                else
                                  setState(() => notification = false);
                              },
                            ),*/
                                  blank,
                                  MaterialButton(
                                      minWidth: double.infinity,
                                      height: 60,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      color: myPrimaryColor,
                                      onPressed: () {
                                        if(_currentVal.text == "Igen") {
                                          Navigator.popAndPushNamed(context, '/wizard');
                                        } else {
                                          Navigator.popAndPushNamed(context, '/choose');
                                        }
                                        //_currentVal.dispose();
                                      },
                                      child: Text('kész'.toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.white))
                                  ),
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
