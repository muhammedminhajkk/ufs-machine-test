import 'package:flutter/material.dart';
import 'package:usf_machine_test/features/homepage/model/product_model.dart';
import 'package:usf_machine_test/features/homepage/services/product_service.dart';

void showdialog(
  BuildContext context,
  int id,
) {
  TextEditingController tittleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categaryController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add A New Product'),
        content: const Text('add details!'),
        actions: <Widget>[
          Column(
            children: [
              TextField(
                controller: tittleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Tittle',
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'description',
                ),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Price',
                ),
              ),
              TextField(
                controller: categaryController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Category',
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  final product = Product(
                      id: id,
                      title: tittleController.text,
                      description: descriptionController.text,
                      category: categaryController.text,
                      image: '',
                      price: double.parse(priceController.text));
                  // Perform some action here
                  ProductService().postProduct(product);
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          )
        ],
      );
    },
  );
}
