import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:test_store_app/application/stores/post_publication_store.dart';

class PostPublPage extends StatefulWidget {
  const PostPublPage({super.key});

  @override
  State<PostPublPage> createState() => _PostPublPageState();
}

class _PostPublPageState extends State<PostPublPage> {
  final _store = PostPublStore();
  final titleContr = TextEditingController();
  final priceContr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: titleContr,
                onChanged: (value) {
                  _store.title = value.trim();
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'title',
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              TextFormField(
                controller: priceContr,
                onChanged: (value) {
                  _store.price = double.parse(value.isEmpty ? '0' : value);
                },
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: true),
                decoration: InputDecoration(
                  hintText: 'price',
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () {
                  _store.postRandom();
                },
                child: const Text('PostRandom')),
            Observer(builder: (_) {
              return ElevatedButton(
                  onPressed: _store.canPost
                      ? () async {
                          await _store.post();
                          titleContr.clear();
                          priceContr.clear();
                        }
                      : null,
                  child: const Text('Post'));
            }),
          ],
        ),
      )),
    );
  }
}
