import 'package:myroutine/enums/skin_problems.dart';
import 'package:myroutine/enums/skin_types.dart';
import 'package:myroutine/models/product.dart';

class MyUser {
  final String uid;

  MyUser({required this.uid});
}

class UserData {
  final String uid;
  final List<SkinProblems> skinProblem;
  final SkinType skinType;
  final List<Product> likedProducts;
  final String userType; //admin vagy mezei felhasználó
  final String DOB;

  UserData({required this.likedProducts, required this.userType, required this.DOB, 
      required this.uid, required this.skinProblem, required this.skinType});
}
