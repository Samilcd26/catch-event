import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Data/State/account_cubit.dart';
import 'Data/State/organizer_cubit.dart';
import 'Data/State/root_cubit.dart';
import 'Data/State/ssfl_cubit.dart';
import 'business/services/impl/AccountService.dart';
import 'business/services/impl/OrganizerService.dart';
import 'business/services/impl/SSFLService.dart';
import 'core/product/navigator/app_router.dart';
import 'core/product/services/network_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();
  final _rootCubit = RootCubit(
      organizerService: OrganizerService(NetworkService.instance.networkManager),
      accoundService: AccountService(NetworkService.instance.networkManager));

  final _accountCubit = AccountCubit(
    accoundService: AccountService(NetworkService.instance.networkManager),
  );

  final _organizerCubit = OrganizerCubit(
    organizerService: OrganizerService(NetworkService.instance.networkManager),
  );
  final _ssflCubit = SSFLCubit(ssflService: SSFLService(NetworkService.instance.networkManager));
  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => _rootCubit,
        ),
        BlocProvider(
          create: (context) => _accountCubit,
          lazy: false,
        ),
        BlocProvider(
          lazy: false,
          create: (context) => _ssflCubit,
        ),
        BlocProvider(
          lazy: false,
          create: (context) => _organizerCubit,
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


/* return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    ); */