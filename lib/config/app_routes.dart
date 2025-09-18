import 'package:distributor_retailer_app/features/auth/presentation/main_screen.dart';
import 'package:distributor_retailer_app/features/auth/presentation/splash_screen.dart';
import 'package:distributor_retailer_app/features/home/presentation/add_distributor_retailer_screen.dart';
import 'package:distributor_retailer_app/features/home/presentation/chart_screen.dart';
import 'package:distributor_retailer_app/features/home/presentation/home_screen.dart';
import 'package:distributor_retailer_app/features/home/presentation/location_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String splash = 'splash';
  static const String home = 'home';
  static const String location = 'location';
  static const String chart = 'chart';
  static const String addDistributorRetailer = 'add_distributor_retailer';

  static GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainScreen(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/location',
            name: location,
            builder: (context, state) => const LocationScreen(),
          ),
          GoRoute(
            path: '/chart',
            name: chart,
            builder: (context, state) => const ChartScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/add_distributor_retailer',
        name: addDistributorRetailer,
        builder: (context, state) {
          final extra = state.extra;
          bool isEdit = false;
          Map<String, dynamic>? distributorData;
          if (extra != null && extra is Map<String, dynamic>) {
            isEdit = extra['isEdit'] ?? false;
            distributorData = extra['distributorData'];
          }
          return AddDistributorRetailerScreen(
            isEdit: isEdit,
            distributorData: distributorData,
          );
        },
      ),
    ],
  );
}
