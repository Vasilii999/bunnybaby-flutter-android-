import 'package:cloud_firestore/cloud_firestore.dart';

class ProductFirebase {
  final String id;
  final String name;
  final int price;
  final int discount;
  final String? description;
  final List<String> imageUrls;
  final double rating;
  ProductFirebase({
    required this.id,
    required this.rating,
    required this.name,
    required this.price,
    required this.discount,
    required this.imageUrls,
    this.description,
  });

  // Для чтения из Firestore (DocumentSnapshot)
  factory ProductFirebase.fromDocument(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return ProductFirebase.fromMap(map, id: doc.id);
  }

  factory ProductFirebase.fromMap(Map<String, dynamic> map, {String id = ''}) {
  return ProductFirebase(
    id: id,
    name: map['name'] ?? '',
    price: map['price'] ?? 0,
    discount: map['discount'] ?? 0,
    imageUrls: List<String>.from(map['imageUrls'] ?? []),
    rating: map['rating'] ?? 0,
    description: map['description'],
  );
}


Map<String,dynamic> toMap(){
  return {
    'name': name,
    'price': price,
    'discount': discount,
    'imageUrls': imageUrls,
    'rating': rating,
    if (description != null) 'description' : description,
  };
}

}