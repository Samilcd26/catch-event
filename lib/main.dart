import 'package:flutter/material.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _rootCubit,
        ),
        BlocProvider(
          create: (context) => _accountCubit,
        ),
        BlocProvider(
          create: (context) => _rootCubit,
        ),
        BlocProvider(
          create: (context) => _ssflCubit,
        ),
        BlocProvider(
          create: (context) => _organizerCubit,
        ),
      ],
      child: MaterialApp.router(
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