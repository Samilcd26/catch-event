import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:threego/components/addEvent/add_event.dart';
import 'package:threego/components/addEvent/search_location.dart';
import 'package:threego/components/authentication/register/register_detail_page.dart';
import 'package:threego/components/discovery/discovery.dart';
import 'package:threego/components/discovery/filter.dart';
import 'package:threego/components/discovery/gmapView/gmap_view.dart';
import 'package:threego/components/discovery/listView/list_view.dart';
import 'package:threego/components/home/home.dart';
import 'package:threego/components/info/event_info.dart';
import 'package:threego/components/info/organizer_info.dart';
import 'package:threego/components/info/user_info.dart';
import 'package:threego/components/ticket/ticket.dart';
import 'package:threego/components/user/user.dart';

import '../../../Data/Models/organizer_model.dart';
import '../../../Data/Models/user_model.dart';

import '../../../components/authentication/login/login_page.dart';
import '../../../components/authentication/register/register_page.dart';

import '../../../components/root.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: '/login', initial: true),
        AutoRoute(page: RegisterRoute.page, path: '/register'),
        AutoRoute(page: RegisterDetailRoute.page, path: '/registerDetail'),
        AutoRoute(page: RootRoute.page, path: '/root', children: [
          AutoRoute(page: HomeRoute.page),
          AutoRoute(
            page: DiscoveryRoute.page,
            children: [
              AutoRoute(page: OrganizerMapRoute.page),
              AutoRoute(page: OrganizerListRoute.page),
            ],
          ),
          AutoRoute(page: AddEventRoute.page),
          AutoRoute(page: TicketRoute.page),
          AutoRoute(page: UserRoute.page),
        ]),
        AutoRoute(page: SearchLocationRoute.page),
        AutoRoute(page: FilterRoute.page),
        AutoRoute(page: OrganizerInfoRoute.page),
        AutoRoute(page: EventInfoRoute.page),
        AutoRoute(page: UserInfoRoute.page),
      ];
}

class $AppRouter {}
