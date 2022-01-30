import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myroutine/enums/skin_problems.dart';
import 'package:myroutine/enums/skin_types.dart';
import 'package:myroutine/models/myuser.dart';
import 'package:myroutine/models/product.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');

  Future updateUserData(SkinProblems skinProblem, SkinType skinType) async {
    return await productCollection
        .doc(uid)
        .set({
          //TODO: befejezni
          'skinProblem': skinProblem, 
          'skinType': skinType
          });
  }

  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Product(
        name: doc.get('name') ?? '',
        brand: doc.get('brand') ?? '',
        skinProblem: doc.get('skinProblem') ?? '',
        skinType: doc.get('skinType') ?? '',
        texture: doc.get('texture') ?? '',
        area: doc.get('area') ?? '',
        category: doc.get('category') ?? '',
        effect: doc.get('effect') ?? '',
        reviews: doc.get('reviews') ?? '',
        ingredients: doc.get('ingredients') ?? '',
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      DOB: snapshot['DOB'],
      skinProblem: snapshot['skinProblem'],
      skinType: snapshot['skinType'],
      userType: snapshot['userType'],
      likedProducts: snapshot['likedProducts'],
    );
  }

  Stream<List<Product>> get products {
    return productCollection.snapshots().map(_productListFromSnapshot);
  }

  Stream<UserData> get userData {
    return productCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}
