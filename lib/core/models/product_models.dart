import 'dart:convert';

// To parse this JSON data, do
// final product = productFromJson(jsonString);

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final Category? category; // Store as enum in memory
  final String? image;
  final Rating? rating;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    category: categoryValues.map[json["category"]], // Mapping the category enum
    image: json["image"],
    rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": categoryValues.reverse[category], // Convert category enum back to string for API
    "image": image,
    "rating": rating?.toJson(),
  };

  // Convert a Product into a Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category != null ? categoryValues.reverse[category] : null, // Store category as String
      'image': image,
      'rating': rating?.rate.toString(), // Store rating as String (rate only, or store as a String for simplicity)
    };
  }

  // Convert a Map into a Product (for SQLite)
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      description: map['description'],
      category: map['category'] != null ? categoryValues.map[map['category']] : null, // Convert back to enum
      image: map['image'],
      rating: map['rating'] != null ? Rating(rate: double.tryParse(map['rating'])) : null, // Convert rating back
    );
  }
}

enum Category {
  ELECTRONICS,
  JEWELERY,
  MEN_S_CLOTHING,
  WOMEN_S_CLOTHING
}

final categoryValues = EnumValues({
  "electronics": Category.ELECTRONICS,
  "jewelery": Category.JEWELERY,
  "men's clothing": Category.MEN_S_CLOTHING,
  "women's clothing": Category.WOMEN_S_CLOTHING
});

class Rating {
  final double? rate;
  final int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rate: json["rate"]?.toDouble(),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "count": count,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
