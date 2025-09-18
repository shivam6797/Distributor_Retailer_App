import 'package:distributor_retailer_app/config/app_routes.dart';
import 'package:distributor_retailer_app/config/app_theme.dart';
import 'package:distributor_retailer_app/core/network/api_client.dart';
import 'package:distributor_retailer_app/features/home/bloc/distributor_retailer_bloc.dart';
import 'package:distributor_retailer_app/features/home/data/repositories/distributor_retailer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiClient>(create: (context) => ApiClient()),
        RepositoryProvider<DistributorRetailerRepository>(
          create: (context) =>
              DistributorRetailerRepository(context.read<ApiClient>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DistributorRetailerBloc>(
            create: (context) => DistributorRetailerBloc(
              context.read<DistributorRetailerRepository>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoutes.router,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
        ),
      ),
    );
  }
}
