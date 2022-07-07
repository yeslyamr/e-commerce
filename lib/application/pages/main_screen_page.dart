import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_store_app/application/navigation/auto_router.dart';

class MainScreenPage extends StatelessWidget {
  const MainScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AutoTabsScaffold(
          routes: const [
            Categories(),
            Post(),
            Cart(),
          ],
          appBarBuilder: (_, tabsRouter) {
            return
                //  tabsRouter.current.name == SearchRouter.name
                //     ? PreferredSize(
                //         preferredSize: Size(0, 0),
                //         child: Container(),
                //       )
                //     :
                AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text(tabsRouter.current.name),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () {
                      AutoRouter.of(context).push(const ProfileRoute());
                    },
                    child: CircleAvatar(
                        foregroundImage:
                            FirebaseAuth.instance.currentUser?.photoURL != null
                                ? NetworkImage(FirebaseAuth
                                        .instance.currentUser?.photoURL ??
                                    '')
                                : null),
                  ),
                )
              ],
              leading: tabsRouter.canPopSelfOrChildren
                  ? const AutoLeadingButton()
                  : null,
            );
          },
          bottomNavigationBuilder:
              (BuildContext context, TabsRouter tabsRouter) {
            return BottomNavigationBar(
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.storefront),
                    label: ('Categories'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    label: ('Post'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: ('Cart'),
                  ),
                ]);
          }),
    );
  }
}
