import 'package:myroutine/enums/areas.dart';
import 'package:myroutine/enums/brands.dart';
import 'package:myroutine/enums/categories.dart';
import 'package:myroutine/enums/effects.dart';
import 'package:myroutine/enums/ingredients.dart';

class Product {
  final String name;
  final String brand;
  final String skinProblem;
  final String skinType;
  final String texture;
  final String area;
  final String category;
  //final List<Effects> effect;
  final String reviews;
  //final List<Ingredients> ingredients;

  Product({required this.name, required this.brand, required this.texture, required this.area, required this.category,
    /*required this.effect, required this.ingredients, */ required this.reviews, required this.skinProblem, required this.skinType});
}
