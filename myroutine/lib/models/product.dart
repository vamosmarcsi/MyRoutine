class Product {
  final String id;
  final String name;
  final String brand;
  final List<String> skinProblem;
  final List<String> skinType;
  final String texture;
  final String area;
  final String category;
  final List<String> effect;
  final List<String> reviews;
  final List<String> ingredients;
  final String picture;
  List<String> routine = [];

  Product({required this.id, required this.name, required this.brand, required this.texture, required this.area, required this.category,
    required this.effect, required this.ingredients, required this.reviews, required this.skinProblem, required this.skinType, required this.picture,});
}
