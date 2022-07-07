import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:provider/provider.dart';
import 'package:test_store_app/application/stores/cart_store.dart';
import 'package:test_store_app/domain/models/product.dart';

class ListCategoriesPage extends StatefulWidget {
  const ListCategoriesPage({super.key});

  @override
  State<ListCategoriesPage> createState() => _ListCategoriesPageState();
}

class _ListCategoriesPageState extends State<ListCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context);

    return Scaffold(
      body: Observer(builder: (_) {
        return ListView.builder(
            itemCount: cartStore.productsFromDB.length,
            itemBuilder: (context, index) {
              final docSnapshot = cartStore.productsFromDB[index];
              final product =
                  Product.fromJson(docSnapshot.data()! as Map<String, dynamic>);
              return Observer(builder: (_) {
                return ListTile(
                  title: Text(product.title),
                  trailing: cartStore.productsInCart.keys
                          .where((element) =>
                              element.reference == docSnapshot.reference)
                          .isNotEmpty
                      ? ElevatedButton(
                          onPressed: () async {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => const Center(
                                    child: CircularProgressIndicator()));
                            await cartStore.removeFromCart(
                                documentSnapshot: docSnapshot);
                            if (!mounted) return;
                            AutoRouter.of(context).pop();
                            setState(() {});
                          },
                          child: const Text('Remove'))
                      : ElevatedButton(
                          onPressed: () async {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => const Center(
                                    child: CircularProgressIndicator()));
                            await cartStore.addToCart(
                                documentSnapshot: docSnapshot,
                                product: product);
                            if (!mounted) return;
                            AutoRouter.of(context).pop();
                            setState(() {});
                          },
                          child: const Icon(Icons.shopping_cart),
                        ),
                );
              });
            });
      }),
    );
  }
}
