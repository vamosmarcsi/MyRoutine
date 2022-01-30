import 'package:myroutine/enums/areas.dart';
import 'package:myroutine/enums/brands.dart';
import 'package:myroutine/enums/categories.dart';
import 'package:myroutine/enums/effects.dart';
import 'package:myroutine/enums/ingredients.dart';

class Product {
  final String name;
  final Brands brand;
  final String skinProblem;
  final String skinType;
  final String texture;
  final Areas area;
  final Categories category;
  final List<Effects> effect;
  final List<String> reviews;
  final List<Ingredients> ingredients;

  Product({required this.name, required this.brand, required this.texture, required this.area, required this.category, required this.effect, required this.reviews, required this.ingredients, required this.skinProblem, required this.skinType});
}
