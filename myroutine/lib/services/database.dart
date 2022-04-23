import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myroutine/models/myuser.dart';
import 'package:myroutine/models/product.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addProduct(
      String name,
      String brand,
      List<String> skinType,
      List<String> skinProblem,
      String category,
      String texture,
      String area,
      List<String> reviews,
      List<String> effects,
      List<String> ingredients) {
    return productCollection
        .add({
          'name': name,
          'brand': brand,
          'skinProblem': skinProblem,
          'skinType': skinType,
          'texture': texture,
          'area': area,
          'reviews': reviews,
          'ingredients': ingredients,
          'category': category,
          'effect': effects
        })
        .then((value) => print("Product Added: $name"))
        .catchError((error) => print("Failed to add product: $error"));
  }

  Future updateUserData(String name, String DOB, String skinType,
      List<String> skinProblem, bool isAdmin) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'DOB': DOB,
      'skinProblem': skinProblem,
      'skinType': skinType,
      'isAdmin': isAdmin
    });
  }

  Future updateID(String id) async {
    return await productCollection
        .doc(id)
        .update({
          'id': id,
        })
        .then((value) => print("ID SET"))
        .catchError((error) => print("Failed to add product: $error"));
  }

  Future updateProductData(
      String id,
      String name,
      String brand,
      List<String> skinType,
      List<String> skinProblem,
      String category,
      String texture,
      String area,
      List<String> reviews,
      List<String> effects,
      List<String> ingredients) async {
    return await productCollection
        .doc(id)
        .update({
          'name': name,
          'brand': brand,
          'skinProblem': skinProblem,
          'category': category,
          'skinType': skinType,
          'texture': texture,
          'area': area,
          'reviews': reviews,
          'ingredients': ingredients,
          'effects': effects
        })
        .then((value) => print("Product Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteUser(String delete) {
    return userCollection
        .doc(delete)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> deleteProduct(String delete) {
    return productCollection
        .doc(delete)
        .delete()
        .then((value) => print("Product Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Product(
        id: 'id',
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
      isAdmin: snapshot['isAdmin'],
      name: snapshot['name'],
      DOB: snapshot['DOB'],
      skinProblem: snapshot['skinProblem'],
      skinType: snapshot['skinType'],
      //likedProducts: snapshot['likedProducts'],
    );
  }

  Stream<List<Product>> get products {
    return productCollection.snapshots().map(_productListFromSnapshot);
  }

  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
