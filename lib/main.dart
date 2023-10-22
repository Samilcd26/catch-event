import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threego/app/app_router.dart';
import 'package:threego/business/impl/AccountService.dart';
import 'package:threego/business/impl/LocationService.dart';
import 'package:threego/business/impl/OrganizerService.dart';
import 'package:threego/business/impl/SSFLService.dart';
import 'package:threego/core/network/network_service.dart';

import 'Data/State/account_cubit.dart';
import 'Data/State/organizer_cubit.dart';
import 'Data/State/ssfl_cubit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  //
  final _appRouter = AppRouter();
  //
  @override
  Widget build(BuildContext context) {
    final accountCubit = AccountCubit(
      locationService: LocationService(NetworkService.getInstance(context).networkManager),
      organizerService: OrganizerService(NetworkService.getInstance(context).networkManager),
      accoundService: AccountService(NetworkService.getInstance(context).networkManager),
    );

    final organizerCubit = OrganizerCubit(
      organizerService: OrganizerService(NetworkService.getInstance(context).networkManager),
    );
    final ssflCubit = SSFLCubit(ssflService: SSFLService(NetworkService.getInstance(context).networkManager));

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (mainContex) => accountCubit,
          lazy: false,
        ),
        BlocProvider(
          lazy: false,
          create: (mainContex) => ssflCubit,
        ),
        BlocProvider(
          lazy: false,
          create: (mainContex) => organizerCubit,
        ),
      ],
      child: MaterialApp.router(
        //theme: isDarkMode ? DarkTheme().darkTheme : LightTheme().lightThem,
        theme: FlexThemeData.light(
          scheme: FlexScheme.hippieBlue,
          colors: FlexSchemeColor.from(primary: const Color.fromRGBO(255, 95, 25, 1), secondary: Colors.green),
        ),
        darkTheme: FlexThemeData.dark(
            scheme: FlexScheme.flutterDash,
            darkIsTrueBlack: true,
            colors: FlexSchemeColor.from(primary: const Color.fromRGBO(255, 95, 25, 1), secondary: Colors.green)),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
