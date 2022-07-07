// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'auto_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter(
      {GlobalKey<NavigatorState>? navigatorKey, required this.authGuard})
      : super(navigatorKey);

  final AuthGuard authGuard;

  @override
  final Map<String, PageFactory> pagesMap = {
    SignInRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const SignInPage());
    },
    SignUpRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const SignUpPage());
    },
    EmailVerificationRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmailVerificationPage());
    },
    PasswordResetRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PasswordResetPage());
    },
    ProfileRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const ProfilePage());
    },
    MainScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const MainScreenPage());
    },
    Cart.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    Post.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    Categories.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    CartRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const CartPage());
    },
    PostPublRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PostPublPage());
    },
    ListCategoriesRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const ListCategoriesPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(SignInRoute.name, path: '/login'),
        RouteConfig(SignUpRoute.name, path: '/register'),
        RouteConfig(EmailVerificationRoute.name, path: '/emailverification'),
        RouteConfig(PasswordResetRoute.name, path: '/login/passwordreset'),
        RouteConfig(ProfileRoute.name, path: '/profile'),
        RouteConfig(MainScreenRoute.name, path: '/', guards: [
          authGuard
        ], children: [
          RouteConfig(Cart.name,
              path: 'cart',
              parent: MainScreenRoute.name,
              children: [
                RouteConfig(CartRoute.name, path: '', parent: Cart.name)
              ]),
          RouteConfig(Post.name,
              path: 'post',
              parent: MainScreenRoute.name,
              children: [
                RouteConfig(PostPublRoute.name, path: '', parent: Post.name)
              ]),
          RouteConfig(Categories.name,
              path: 'categories',
              parent: MainScreenRoute.name,
              children: [
                RouteConfig(ListCategoriesRoute.name,
                    path: '', parent: Categories.name)
              ])
        ])
      ];
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute() : super(SignInRoute.name, path: '/login');

  static const String name = 'SignInRoute';
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute() : super(SignUpRoute.name, path: '/register');

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [EmailVerificationPage]
class EmailVerificationRoute extends PageRouteInfo<void> {
  const EmailVerificationRoute()
      : super(EmailVerificationRoute.name, path: '/emailverification');

  static const String name = 'EmailVerificationRoute';
}

/// generated route for
/// [PasswordResetPage]
class PasswordResetRoute extends PageRouteInfo<void> {
  const PasswordResetRoute()
      : super(PasswordResetRoute.name, path: '/login/passwordreset');

  static const String name = 'PasswordResetRoute';
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute() : super(ProfileRoute.name, path: '/profile');

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [MainScreenPage]
class MainScreenRoute extends PageRouteInfo<void> {
  const MainScreenRoute({List<PageRouteInfo>? children})
      : super(MainScreenRoute.name, path: '/', initialChildren: children);

  static const String name = 'MainScreenRoute';
}

/// generated route for
/// [EmptyRouterPage]
class Cart extends PageRouteInfo<void> {
  const Cart({List<PageRouteInfo>? children})
      : super(Cart.name, path: 'cart', initialChildren: children);

  static const String name = 'Cart';
}

/// generated route for
/// [EmptyRouterPage]
class Post extends PageRouteInfo<void> {
  const Post({List<PageRouteInfo>? children})
      : super(Post.name, path: 'post', initialChildren: children);

  static const String name = 'Post';
}

/// generated route for
/// [EmptyRouterPage]
class Categories extends PageRouteInfo<void> {
  const Categories({List<PageRouteInfo>? children})
      : super(Categories.name, path: 'categories', initialChildren: children);

  static const String name = 'Categories';
}

/// generated route for
/// [CartPage]
class CartRoute extends PageRouteInfo<void> {
  const CartRoute() : super(CartRoute.name, path: '');

  static const String name = 'CartRoute';
}

/// generated route for
/// [PostPublPage]
class PostPublRoute extends PageRouteInfo<void> {
  const PostPublRoute() : super(PostPublRoute.name, path: '');

  static const String name = 'PostPublRoute';
}

/// generated route for
/// [ListCategoriesPage]
class ListCategoriesRoute extends PageRouteInfo<void> {
  const ListCategoriesRoute() : super(ListCategoriesRoute.name, path: '');

  static const String name = 'ListCategoriesRoute';
}
