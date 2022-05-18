import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myroutine/services/auth.dart';
import 'package:myroutine/services/constants.dart';
import 'package:myroutine/services/database.dart';
import 'package:myroutine/screens/home/side_menu.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final future = DatabaseService(uid: _auth.getUid()).currentUserData();
    return Scaffold(
      backgroundColor: myPrimaryLightColor,
      drawer: const SideMenu(),
      appBar: AppBar(
        backgroundColor: myPrimaryLightColor,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/wizard');
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              )),
          IconButton(
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushNamed(context, '/welcome');
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "MyRoutine",
            style: GoogleFonts.comforter(
                fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white),
          ),
          FutureBuilder<DocumentSnapshot>(
              future: future,
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }
                if (snapshot.hasData && !snapshot.data!.exists) {
                  return Text("Document does not exist");
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  print(data['routine']);
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .where('id', whereIn: data["routine"])
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      return Flexible(
                        child: ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Card(
                                    margin: const EdgeInsets.fromLTRB(
                                        20.0, 6.0, 20.0, 0.0),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 25.0,
                                        backgroundColor: myPrimaryColor,
                                      ),
                                      title: Text(data['name']),
                                      subtitle: Text(data['brand']),
                                    )));
                          }).toList(),
                        ),
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
