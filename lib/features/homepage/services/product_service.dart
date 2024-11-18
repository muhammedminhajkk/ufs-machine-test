import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:usf_machine_test/features/homepage/model/product_model.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    const url = 'https://fakestoreapi.com/products';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      print('errrrr');
      throw Exception('Failed to load products');
    }
  }

  Future<void> deleteProduct(int productId) async {
    final url = Uri.parse(
        'https://fakestoreapi.com/products/$productId'); // Correct URL for DELETE request
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('Product deleted successfully!');
      } else {
        print('Failed to delete product: ${response.body}');
      }
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  Future<void> postProduct(Product product) async {
    final url = Uri.parse('https://fakestoreapi.com/products');

    try {
      // Convert the product to JSON format
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: jsonEncode(product.toJson()), // Convert the product to JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Product posted successfully!');
      } else {
        print('Failed to post product: ${response.body}');
      }
    } catch (e) {
      print('Error posting product: $e');
    }
  }
}
