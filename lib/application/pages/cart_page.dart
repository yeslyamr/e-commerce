import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:test_store_app/application/stores/cart_store.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context);

    return Scaffold(
      body: FutureBuilder(
          future: cartStore.fetchCartDataFromFirestore(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Observer(builder: (context) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.75,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2),
                    itemCount: cartStore.productsInCart.length,
                    itemBuilder: (BuildContext context, int index) {
                      final entry =
                          cartStore.productsInCart.entries.elementAt(index);
                      final currentProduct = entry.key;

                      return Container(
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
                            Text(
                                'ID: ${currentProduct.id} Total: ${doubleWithoutDecimalToInt((currentProduct.price ?? 0) * entry.value)}\$')
                          ],
                        ),
                      );
                    },
                  );
                });
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());

              default:
                return const Text('Some Error');
            }
          }),
      bottomNavigationBar: BottomAppBar(child: Observer(builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: cartStore.canBuy
                    ? () async {
                        await cartStore.purchase();
                      }
                    : null,
                child: const Text('Buy')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    'Total price: ${doubleWithoutDecimalToInt(cartStore.totalPrice)}\$'),
                Text('Total products: ${cartStore.totalProducts.toString()}'),
              ],
            )
          ],
        );
      })),
    );
  }
}

String doubleWithoutDecimalToInt(num val) {
  return val % 1 == 0 ? val.toInt().toString() : val.toStringAsFixed(2);
}
