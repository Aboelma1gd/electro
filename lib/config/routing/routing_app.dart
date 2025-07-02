import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';

import 'package:electro/config/routing/routes.dart';
import 'package:electro/core/widgets/custom_bottom_nav.dart';
import 'package:electro/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:electro/features/home/presentation/cubit/fetchcategories/cubit/categories_cubit.dart';
import 'package:electro/features/home/presentation/cubit/productscubit/cubit/products_cubit.dart';
import 'package:electro/features/reviews/presentation/widgets/reviews_view_body.dart';

import 'package:electro/features/authintication/presentation/screens/forgetpassword_view.dart';
import 'package:electro/features/authintication/presentation/screens/login_view.dart';
import 'package:electro/features/authintication/presentation/screens/signup_view.dart';
import 'package:electro/features/cart/presentation/screens/cart_view.dart';
import 'package:electro/features/checkout/presentation/screens/checkout_view.dart';
import 'package:electro/features/home/domain/entities/product_entity.dart';
import 'package:electro/features/home/presentation/screens/details_view.dart';
import 'package:electro/features/home/presentation/screens/search_view.dart';
import 'package:electro/features/home/presentation/screens/home_view.dart';
import 'package:electro/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:electro/features/notifications/presentation/screens/notification_view.dart';
import 'package:electro/features/home/presentation/widgets/products_gridview.dart';
import 'package:electro/features/home/presentation/widgets/shop_by_categories.dart';
import 'package:electro/features/onboarding/presentation/screens/onboarding_view.dart';
import 'package:electro/features/profile/presentation/screens/profile_view.dart';
import 'package:electro/features/splashscreen/presentation/screens/splashscreen_view.dart';

final sl = GetIt.instance;

final _rootNavigatorKey = GlobalKey<NavigatorState>();
// final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final CartCubit cartCubit = sl<CartCubit>();
  static final CategoriesCubit categoriesCubit = sl<CategoriesCubit>()
    ..fetchCategories();

  static final ProductsCubit productsCubit = sl<ProductsCubit>();

  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: Routes.splash,
        name: 'splash',
        builder: (context, state) => const SplashscreenView(),
      ),
      GoRoute(
        path: Routes.login,
        name: 'login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: Routes.register,
        name: 'register',
        builder: (context, state) => const SignupView(),
      ),
      // StatefulShellRoute for bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: cartCubit),
              BlocProvider.value(value: categoriesCubit),
            ],
            child: Salmon(navigationShell: navigationShell),
          );
        },
        branches: [
          // Home Branch
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: Routes.home,
                name: 'home',
                builder: (context, state) => const HomeView(),
              ),
            ],
          ),
          // Notifications Branch
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: Routes.notifications,
                name: 'notifications',
                builder: (context, state) => BlocProvider.value(
                  value: sl<NotificationsCubit>(),
                  child: const NotificationView(),
                ),
              ),
            ],
          ),
          // Cart Branch
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: Routes.cart,
                name: 'cart',
                builder: (context, state) => BlocProvider.value(
                  value: cartCubit,
                  child: const CartView(),
                ),
              ),
            ],
          ),
          // Profile Branch
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: Routes.profile,
                name: 'profile',
                builder: (context, state) => const ProfileView(),
              ),
            ],
          ),
        ],
      ),
      // Other top-level routes outside the shell
      GoRoute(
        path: '${Routes.products}/:categoryId',
        name: 'products',
        builder: (context, state) {
          final categoryId = state.pathParameters['categoryId']!;
          print("Category ID: $categoryId");
          return BlocProvider.value(
            value: productsCubit..getProducts(categoryId),
            child: ProductsGridView(categoryId: categoryId),
          );
        },
      ),
      GoRoute(
        path: Routes.search,
        name: 'search',
        builder: (context, state) => const SearchView(),
      ),
      GoRoute(
        path: Routes.forgetpassword,
        name: 'forgetpassword',
        builder: (context, state) => const ForgetpasswordView(),
      ),
      GoRoute(
        path: Routes.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: Routes.details,
        name: 'details',
        builder: (context, state) {
          final product = state.extra as ProductEntity;
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: cartCubit),
              BlocProvider.value(value: productsCubit),
            ],
            child: DetailsView(product: product),
          );
        },
      ),
      GoRoute(
        path: Routes.shopbycategories,
        name: 'shopbycategories',
        builder: (context, state) => BlocProvider.value(
          value: categoriesCubit,
          child: const ShopByCategories(),
        ),
      ),
      GoRoute(
        path: Routes.checkout,
        name: 'checkout',
        builder: (context, state) => BlocProvider.value(
          value: cartCubit,
          child: const CheckoutView(),
        ),
      ),
      GoRoute(
        path: Routes.reviews,
        name: 'reviews',
        builder: (context, state) {
          final product = state.extra as ProductEntity;
          return ReviewsView(product: product);
        },
      ),
    ],
    errorBuilder: (context, state) =>
        ErrorPage(routeName: state.uri.toString()),
  );
}

class ErrorPage extends StatelessWidget {
  final String? routeName;
  const ErrorPage({super.key, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('No route defined for $routeName')),
    );
  }
}
