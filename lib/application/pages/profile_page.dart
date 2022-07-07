import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:test_store_app/application/navigation/auto_router.dart';
import 'package:test_store_app/application/stores/auth/auth_store.dart';
import 'package:test_store_app/application/stores/profile_store.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _store = ProfileStore();

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile page'),
          actions: [
            IconButton(
                onPressed: () {
                  authStore.signOut();
                  AutoRouter.of(context).replace(const SignInRoute());
                },
                icon: const Icon(Icons.logout)),
            IconButton(
                onPressed: () {
                  _store.deleteAllPublication();
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: FutureBuilder(
          future: _store.fetchMyPublications(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Observer(builder: (_) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final entry =
                          _store.myPublications.entries.elementAt(index);
                      return ListTile(
                        title: Text('Title: ${entry.value.title}'),
                        subtitle: Text(
                            'Price: ${entry.value.price.toStringAsFixed(2)}\$'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await _store.deletePublication(docRef: entry.key);
                          },
                        ),
                      );
                    },
                    itemCount: _store.myPublications.length,
                  );
                });

              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
