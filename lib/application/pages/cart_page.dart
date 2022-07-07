import 'package:auto_route/auto_route.dart';
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
  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context);
    return Scaffold(
      body: Observer(builder: (_) {
        cartStore.productsInCart;
        return ListView.builder(
            itemCount: cartStore.productsInCart.length,
            itemBuilder: (context, index) {
              final entry = cartStore.productsInCart.entries.elementAt(index);
              return ListTile(
                title: Text(entry.value.title),
                trailing: IconButton(
                  onPressed: () async {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()));
                    await cartStore.removeFromCart(documentSnapshot: entry.key);
                    if (!mounted) return;
                    AutoRouter.of(context).pop();
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete_outline),
                ),
              );
            });
      }),
      bottomNavigationBar: BottomAppBar(child: Observer(builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    'Total price: ${doubleWithoutDecimalToInt(cartStore.totalPrice)}\$'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: cartStore.canBuy
                        ? () async {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => const Center(
                                    child: CircularProgressIndicator()));
                            await cartStore.purchaseCart();
                            if (!mounted) return;
                            AutoRouter.of(context).pop();
                          }
                        : null,
                    child: const Text('Buy')),
              ],
            ),
          ],
        );
      })),
    );
  }
}

String doubleWithoutDecimalToInt(num val) {
  return val % 1 == 0 ? val.toInt().toString() : val.toStringAsFixed(2);
}
