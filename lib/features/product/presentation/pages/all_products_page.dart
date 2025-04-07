import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cleanarch/features/product/presentation/riverpod/all_products/all_products_state.dart';

import '../riverpod/product_provider.dart';

class AllProductsPage extends ConsumerStatefulWidget {
  const AllProductsPage({super.key});

  @override
  ConsumerState createState() => _AllProductsPageState();
}

class _AllProductsPageState extends ConsumerState<AllProductsPage> {
  void getAllProducts() {
    ref.read(allProductsProvider.notifier).fetchAllProducts();
  }

  void searchAllProducts({required String word}) {
    ref.read(allProductsProvider.notifier).searchProducts(word: word);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final allProductsState = ref.watch(allProductsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All products",
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              getAllProducts();
            },
            icon: const Icon(
              Icons.get_app,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Search",
              ),
              onChanged: (String value) {
                if (value == "") {
                  getAllProducts();
                } else {
                  searchAllProducts(word: value);
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(allProductsProvider.notifier)
                        .sortProductsUsecase(sortName: "title", ascDesc: "asc");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Change border radius
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12), // Padding
                  ),
                  child: const Text(
                    "Title",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(allProductsProvider.notifier)
                        .sortProductsUsecase(sortName: "price", ascDesc: "asc");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Change border radius
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12), // Padding
                  ),
                  child: const Text(
                    "Price",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(allProductsProvider.notifier).sortProductsUsecase(
                        sortName: "rating", ascDesc: "asc");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Change border radius
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12), // Padding
                  ),
                  child: const Text(
                    "Rating",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            if (allProductsState is AllProductsLoading)
              const CircularProgressIndicator(),
            if (allProductsState is AllProductsError)
              Text(allProductsState.message),
            if (allProductsState is AllProductsLoaded)
              Expanded(
                child: ListView.builder(
                    itemCount: allProductsState.allProducts.products.length,
                    itemBuilder: (context, index) {
                      final product =
                          allProductsState.allProducts.products[index];

                      return ListTile(
                        leading: CircleAvatar(
                          child: Image.network(
                            product.thumbnail,
                          ),
                        ),
                        title: Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          product.price.toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      );
                    }),
              ),
          ],
        ),
      ),
    );
  }
}
