// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

// Product productFromJson(String str) => Product.fromJson(json.decode(str));

// String productToJson(Product data) => json.encode(data.toJson());

class Product {
  final int id;
  final String title;
  final String image;
  final double price; // This should be a double
  final String description;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      price: (json['price'] is int)
          ? json['price'].toDouble()
          : json['price'], // Convert price to double
      description: json['description'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
      };
}
