import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myroutine/screens/wizard/wizard_product_tile.dart';
import 'package:myroutine/services/auth.dart';
import 'package:myroutine/services/database.dart';

class WizardProductList extends StatefulWidget {
  //const WizardProductList({Key? key}) : super(key: key);
  late String category;
  WizardProductList({required category});

  @override
  State<WizardProductList> createState() => _WizardProductListState();
}

class _WizardProductListState extends State<WizardProductList> {
  @override
  Widget build(BuildContext context) {
    final future =
        DatabaseService(uid: AuthService().getUid()).currentUserData();
    //Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance.collection('products').where('skinType', arrayContains: doc["SkinType"]).snapshots();
    return FutureBuilder<DocumentSnapshot>(
        future: future,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          print("kifli");
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            print(data);
            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  //.where('skinType'.contains(data["skinType"]), isEqualTo: true)
                  .where('skinProblem', arrayContainsAny: data["skinProblem"])
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                return Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return WizardProductTile(data: data, id: document.id);
                    }).toList(),
                  ),
                );
              },
            );
          }

          return Text("loading",
              style: TextStyle(fontSize: 20, color: Colors.white));
        });
  }
}
