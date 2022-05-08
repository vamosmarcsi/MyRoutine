import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myroutine/screens/wizard/wizard_product_tile.dart';
import 'package:myroutine/services/constants.dart';

import '../../services/auth.dart';
import '../../services/database.dart';

class Wizard extends StatefulWidget {
  const Wizard({Key? key}) : super(key: key);

  @override
  State<Wizard> createState() => _WizardState();
}

class _WizardState extends State<Wizard> {
  @override
  Widget build(BuildContext context) {
    final future =
        DatabaseService(uid: AuthService().getUid()).currentUserData();
    return Scaffold(
      backgroundColor: myPrimaryLightColor,
      appBar: AppBar(
        backgroundColor: myPrimaryLightColor,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white)),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: () {
                Navigator.popAndPushNamed(context, '/home');
              }, icon: Icon(Icons.check)),
            ],
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Varázsló",
            style: GoogleFonts.comforter(
                fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white),
          ),
          FutureBuilder<DocumentSnapshot>(
              future: future,
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                //print("kifli");
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }
                if (snapshot.hasData && !snapshot.data!.exists) {
                  return Text("Document does not exist");
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  //print(data);
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        //.where('skinType'.contains(data["skinType"]), isEqualTo: true)
                        .where('skinProblem',
                            arrayContainsAny: data["skinProblem"])
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      return Flexible(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: categories.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Ajánlott ${categories[index]}: "),
                                    Flexible(
                                      child: ListView(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        children: snapshot.data!.docs
                                            .map((DocumentSnapshot document) {
                                          Map<String, dynamic> data = document
                                              .data()! as Map<String, dynamic>;
                                          return WizardProductTile(
                                              data: data, id: document.id);
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      );
                    },
                  );
                }

                return Text("loading",
                    style: TextStyle(fontSize: 20, color: Colors.white));
              })
        ],
      ),
    );
  }
}
