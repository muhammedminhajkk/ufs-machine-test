import 'package:flutter/material.dart';
import 'package:usf_machine_test/features/homepage/model/product_model.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;
  final String title;
  const DetailsScreen({super.key, required this.product, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(product.image))),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${product.price}\$',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Description:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(product.description),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Category::',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(product.category)
        ],
      ),
    );
  }
}
