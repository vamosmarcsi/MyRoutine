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

  Product({required this.id, required this.name, required this.brand, required this.texture, required this.area, required this.category,
    required this.effect, required this.ingredients, required this.reviews, required this.skinProblem, required this.skinType});
}
