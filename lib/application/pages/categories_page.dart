import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:test_store_app/application/navigation/auto_router.dart';
import 'package:test_store_app/application/stores/categories_store.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final _store = CategoryStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context) {
          _store.categories;
          return FutureBuilder(
              future: _store.getCategories(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return GridView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: _store.categories.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            context.router.push(ProductsRoute(
                                category: _store.categories[index]));
                          },
                          child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            alignment: Alignment.center,
                            child: Text(
                              _store.categories[index],
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              crossAxisCount: 2),
                    );

                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());

                  default:
                    return const Text('Some Error');
                }
              });
        },
      ),
    );
  }
}
