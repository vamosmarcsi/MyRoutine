import 'package:myroutine/models/product.dart';

class MyUser {
  final String uid;

  MyUser({required this.uid});
}

class UserData {
  //final String uid;
  List<String> skinProblem;
  String skinType;
  //List<Product> likedProducts;
  final String DOB;
  String name;
  bool isAdmin;
  String profile_pic;
  List<String> routine;

  UserData({required this.routine, required this.DOB, required this.skinProblem, required this.skinType, required this.name, required this.isAdmin, required this.profile_pic});
}
