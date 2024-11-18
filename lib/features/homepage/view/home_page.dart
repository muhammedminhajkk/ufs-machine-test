import 'package:flutter/material.dart';
import 'package:usf_machine_test/features/detailspage/details_page.dart';
import 'package:usf_machine_test/features/dialog/show_dialog.dart';
import 'package:usf_machine_test/features/homepage/model/product_model.dart';
import 'package:usf_machine_test/features/homepage/services/product_service.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = ProductService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          final productList = snapshot.data!;

          return Scaffold(
            body: ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  String title = productList[index].title;

                  List<String> words = title.split(' ');
                  String croppedTitle =
                      words.length > 2 ? '${words[0]} ${words[1]}' : title;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                                  title: croppedTitle,
                                  product: productList[index],
                                )),
                      );
                    },
                    child: Card(
                      elevation: 10,
                      color: const Color.fromARGB(255, 33, 134, 250),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          productList[index].image)),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  croppedTitle,
                                  softWrap: true,
                                  maxLines:
                                      2, // Set to the maximum number of lines you want
                                  overflow: TextOverflow
                                      .visible, // Allows the text to wrap to the next line
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '${productList[index].price}\$',
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 25.0, right: 24),
                            child: IconButton(
                                onPressed: () {
                                  ProductService().deleteProduct(index);

                                  setState(() {
                                    productList.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  color: Colors.black,
                                  Icons.delete,
                                  size: 40,
                                )),
                          )
                        ],
                      ),
                    ),
                  );
                }),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showdialog(context, snapshot.data!.length + 1);
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
