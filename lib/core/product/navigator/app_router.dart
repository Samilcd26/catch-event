import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../Data/Models/organizer_model.dart';
import '../../../Data/Models/user_model.dart';
import '../../../components/addEvent/view/add_event.dart';
import '../../../components/addEvent/view/search_location.dart';
import '../../../components/authentication/login/login_page.dart';
import '../../../components/authentication/register/register_page.dart';
import '../../../components/discovery/view/discovery.dart';
import '../../../components/discovery/view/filter.dart';
import '../../../components/discovery/view/gmapView/gmap_view.dart';
import '../../../components/discovery/view/listView/list_view.dart';
import '../../../components/home/view/home.dart';
import '../../../components/info/view/event_info.dart';
import '../../../components/info/view/organizer_info.dart';
import '../../../components/info/view/user_info.dart';
import '../../../components/root.dart';
import '../../../components/ticket/view/ticket.dart';
import '../../../components/user/view/user.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: '/login', initial: true),
        AutoRoute(page: RegisterRoute.page, path: '/register'),
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
