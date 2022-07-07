import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_store_app/application/pages/auth/email_verification_page.dart';
import 'package:test_store_app/application/pages/auth/password_reset_page.dart';
import 'package:test_store_app/application/pages/auth/sign_in_page.dart';
import 'package:test_store_app/application/pages/auth/sign_up_page.dart';
import 'package:test_store_app/application/pages/cart_page.dart';
import 'package:test_store_app/application/pages/list_categories_page.dart';
import 'package:test_store_app/application/pages/main_screen_page.dart';
import 'package:test_store_app/application/pages/post_publication_page.dart';
import 'package:test_store_app/application/pages/profile_page.dart';

part 'auto_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      page: SignInPage,
      path: '/login',
    ),
    AutoRoute(
      page: SignUpPage,
      path: '/register',
    ),
    AutoRoute(
      page: EmailVerificationPage,
      path: '/emailverification',
    ),
    AutoRoute(
      page: PasswordResetPage,
      path: '/login/passwordreset',
    ),
    AutoRoute(
      page: ProfilePage,
      path: '/profile',
    ),
    AutoRoute(
      page: MainScreenPage,
      initial: true,
      guards: [AuthGuard],
      path: '/',
      children: [
        AutoRoute(
          page: EmptyRouterPage,
          name: 'Cart',
          path: 'cart',
          children: [
            AutoRoute(
              page: CartPage,
              path: '',
            ),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'Post',
          path: 'post',
          children: [
            AutoRoute(
              page: PostPublPage,
              path: '',
            )
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'Categories',
          path: 'categories',
          children: [
            AutoRoute(
              page: ListCategoriesPage,
              path: '',
            )
          ],
        ),
      ],
    ),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter({required super.authGuard});
}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // takes current user if signed in or null otherwise
    final User? currentUser = FirebaseAuth.instance.currentUser;

    // checks if user is signed in
    final bool isLoggedIn = currentUser != null;

    // checks if user verified the email
    final bool isEmailVerified = currentUser?.emailVerified ?? false;

    if (isLoggedIn && isEmailVerified) {
      resolver.next(true);
    } else if (isLoggedIn && !isEmailVerified) {
      router.push(const EmailVerificationRoute());
    } else {
      router.push(const SignInRoute());
    }
  }
}
