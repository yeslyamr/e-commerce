import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:test_store_app/application/navigation/auto_router.dart';
import 'package:test_store_app/application/stores/cart_store.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, required this.category});

  final String category;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context);

    return Scaffold(
        body: FutureBuilder(
          future: cartStore.getProductsAndFetchCart(
              cartStore: cartStore, category: widget.category),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: cartStore.productsStore.products.length,
                  itemBuilder: (context, index) {
                    final currentProduct =
                        cartStore.productsStore.products[index];

                    return InkWell(
                      onTap: () {
                        context.router
                            .push(ProductInfoRoute(product: currentProduct));
                      },
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            ColoredBox(
                              color: Colors.yellow,
                              child: AspectRatio(
                                aspectRatio: 1.5,
                                child:
                                    Image.network(currentProduct.image ?? ''),
                              ),
                            ),
                            Expanded(
                              child: ColoredBox(
                                color: Colors.green,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    currentProduct.title ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                                '${doubleWithoutDecimalToInt(currentProduct.price ?? 0)}\$'),
                            Observer(builder: (_) {
                              cartStore.productsInCart;

                              return cartStore.productsInCart
                                      .containsKey(currentProduct)
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              _debounce?.cancel();
                                              cartStore.decrementQuantity(
                                                  product: currentProduct);
                                              _debounce = Timer(
                                                  const Duration(
                                                      milliseconds: 300),
                                                  () async {
                                                await cartStore
                                                    .sendToFirestore();
                                              });
                                            },
                                            child: const Icon(Icons.remove)),
                                        Text(cartStore
                                            .productsInCart[currentProduct]
                                            .toString()),
                                        ElevatedButton(
                                            onPressed: () {
                                              _debounce?.cancel();
                                              cartStore.incrementQuantity(
                                                  product: currentProduct);

                                              _debounce = Timer(
                                                  const Duration(
                                                      milliseconds: 300),
                                                  () async {
                                                await cartStore
                                                    .sendToFirestore();
                                              });
                                            },
                                            child: const Icon(Icons.add))
                                      ],
                                    )
                                  : ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.blue)),
                                      onPressed: () {
                                        _debounce?.cancel();

                                        cartStore.incrementQuantity(
                                            product: currentProduct);
                                        _debounce = Timer(
                                            const Duration(milliseconds: 300),
                                            () async {
                                          await cartStore.sendToFirestore();
                                        });
                                      },
                                      child: const Text('Add to cart'),
                                    );
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.75,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2),
                );

              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());

              default:
                return const Text('Some Error');
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await cartStore.test();
          },
        ));
  }
}

String doubleWithoutDecimalToInt(num val) {
  return val % 1 == 0 ? val.toInt().toString() : val.toStringAsFixed(2);
}
