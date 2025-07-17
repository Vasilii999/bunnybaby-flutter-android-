class Product {
  final String name;
  final int price;
  final int discount;
  final String? description;
  final List<String> imagePath;
  final double rating;
  final List<String>? availableSizes;
  final List<String>? availableColors;
  Product({
    required this.rating,
    required this.name,
    required this.price,
    required this.discount,
    required this.imagePath,
    this.description,
    this.availableSizes,
    this.availableColors,
  });

}