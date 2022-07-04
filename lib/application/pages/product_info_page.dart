import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:test_store_app/application/stores/cart_store.dart';
import 'package:test_store_app/domain/models/product.dart';

class ProductInfoPage extends StatefulWidget {
  const ProductInfoPage({super.key, required this.product});

  final Product product;

  @override
  State<ProductInfoPage> createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context);

    return Scaffold(
        body: Center(child: Text(widget.product.title ?? '')),
        bottomNavigationBar: BottomAppBar(
          child: Observer(builder: (_) {
            cartStore.productsInCart;

            return cartStore.productsInCart.containsKey(widget.product)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _debounce?.cancel();
                            cartStore.decrementQuantity(
                                product: widget.product);
                            _debounce = Timer(const Duration(milliseconds: 300),
                                () async {
                              await cartStore.sendToFirestore();
                            });
                          },
                          child: const Icon(Icons.remove)),
                      Text(cartStore.productsInCart[widget.product].toString()),
                      ElevatedButton(
                          onPressed: () {
                            _debounce?.cancel();
                            cartStore.incrementQuantity(
                                product: widget.product);

                            _debounce = Timer(const Duration(milliseconds: 300),
                                () async {
                              await cartStore.sendToFirestore();
                            });
                          },
                          child: const Icon(Icons.add))
                    ],
                  )
                : ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () {
                      _debounce?.cancel();

                      cartStore.incrementQuantity(product: widget.product);
                      _debounce =
                          Timer(const Duration(milliseconds: 300), () async {
                        await cartStore.sendToFirestore();
                      });
                    },
                    child: const Text('Add to cart'),
                  );
          }),
        ));
  }
}
