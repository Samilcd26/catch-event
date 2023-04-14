import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Data/Models/organizer_model.dart';
import '../../../Data/Models/user_model.dart';
import '../../../components/addEvent/view/add_event.dart';
import '../../../components/addEvent/view/search_location.dart';
import '../../../components/discovery/view/discovery.dart';
import '../../../components/discovery/view/filter.dart';
import '../../../components/discovery/view/gmapView/gmap_view.dart';
import '../../../components/discovery/view/listView/list_view.dart';
import '../../../components/home/view/home.dart';
import '../../../components/info/view/event_info.dart';
import '../../../components/info/view/organizer_info.dart';
import '../../../components/root.dart';
import '../../../components/ticket/view/ticket.dart';
import '../../../components/user/view/user.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
    replaceInRouteName: 'Page,Route',
// Routers List
    routes: <AutoRoute>[
      AutoRoute(page: RootPage, path: '/root', initial: true, children: [
        AutoRoute(page: HomePage),
        AutoRoute(
          page: DiscoveryPage,
          children: [
            AutoRoute(page: OrganizerMapPage),
            AutoRoute(page: OrganizerListPage),
          ],
        ),
        AutoRoute(page: AddEventPage),
        AutoRoute(page: TicketPage),
        AutoRoute(page: UserPage),
      ]),
      AutoRoute(page: SearchLocationPage),
      AutoRoute(page: FilterPage),
      AutoRoute(page: OrganizerInfoPage),
      AutoRoute(page: EventInfoPage),
    ])

// extend the generated private router
class AppRouter extends _$AppRouter {}
