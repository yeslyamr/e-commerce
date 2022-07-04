import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_store_app/application/navigation/auto_router.dart';

import '../stores/auth/auth_store.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Profile Page'),
          ElevatedButton(
              onPressed: () {
                authStore.signOut();
                // AutoRouter.of(context).
                AutoRouter.of(context).replaceAll([const SignInRoute()]);
              },
              child: const Text('sign out')),
        ],
      )),
    );
  }
}
