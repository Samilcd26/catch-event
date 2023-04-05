// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    RootRoute.name: (routeData) {
      final args =
          routeData.argsAs<RootRouteArgs>(orElse: () => const RootRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: RootPage(key: args.key),
      );
    },
    FilterRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const FilterPage(),
      );
    },
    OrganizerInfoRoute.name: (routeData) {
      final args = routeData.argsAs<OrganizerInfoRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: OrganizerInfoPage(
          key: args.key,
          organizerModel: args.organizerModel,
        ),
      );
    },
    EventInfoRoute.name: (routeData) {
      final args = routeData.argsAs<EventInfoRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: EventInfoPage(
          key: args.key,
          event: args.event,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    DiscoveryRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const DiscoveryPage(),
      );
    },
    AddEventRoute.name: (routeData) {
      final args = routeData.argsAs<AddEventRouteArgs>(
          orElse: () => const AddEventRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: AddEventPage(key: args.key),
      );
    },
    TicketRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const TicketPage(),
      );
    },
    UserRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const UserPage(),
      );
    },
    OrganizerMapRoute.name: (routeData) {
      final args = routeData.argsAs<OrganizerMapRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: OrganizerMapPage(
          key: args.key,
          organizerdata: args.organizerdata,
          currentPosition: args.currentPosition,
        ),
      );
    },
    OrganizerListRoute.name: (routeData) {
      final args = routeData.argsAs<OrganizerListRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: OrganizerListPage(
          key: args.key,
          organizerdata: args.organizerdata,
        ),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/root',
          fullMatch: true,
        ),
        RouteConfig(
          RootRoute.name,
          path: '/root',
          children: [
            RouteConfig(
              HomeRoute.name,
              path: 'home-page',
              parent: RootRoute.name,
            ),
            RouteConfig(
              DiscoveryRoute.name,
              path: 'discovery-page',
              parent: RootRoute.name,
              children: [
                RouteConfig(
                  OrganizerMapRoute.name,
                  path: 'organizer-map-page',
                  parent: DiscoveryRoute.name,
                ),
                RouteConfig(
                  OrganizerListRoute.name,
                  path: 'organizer-list-page',
                  parent: DiscoveryRoute.name,
                ),
              ],
            ),
            RouteConfig(
              AddEventRoute.name,
              path: 'add-event-page',
              parent: RootRoute.name,
            ),
            RouteConfig(
              TicketRoute.name,
              path: 'ticket-page',
              parent: RootRoute.name,
            ),
            RouteConfig(
              UserRoute.name,
              path: 'user-page',
              parent: RootRoute.name,
            ),
          ],
        ),
        RouteConfig(
          FilterRoute.name,
          path: '/filter-page',
        ),
        RouteConfig(
          OrganizerInfoRoute.name,
          path: '/organizer-info-page',
        ),
        RouteConfig(
          EventInfoRoute.name,
          path: '/event-info-page',
        ),
      ];
}

/// generated route for
/// [RootPage]
class RootRoute extends PageRouteInfo<RootRouteArgs> {
  RootRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          RootRoute.name,
          path: '/root',
          args: RootRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'RootRoute';
}

class RootRouteArgs {
  const RootRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'RootRouteArgs{key: $key}';
  }
}

/// generated route for
/// [FilterPage]
class FilterRoute extends PageRouteInfo<void> {
  const FilterRoute()
      : super(
          FilterRoute.name,
          path: '/filter-page',
        );

  static const String name = 'FilterRoute';
}

/// generated route for
/// [OrganizerInfoPage]
class OrganizerInfoRoute extends PageRouteInfo<OrganizerInfoRouteArgs> {
  OrganizerInfoRoute({
    Key? key,
    required OrganizerModel organizerModel,
  }) : super(
          OrganizerInfoRoute.name,
          path: '/organizer-info-page',
          args: OrganizerInfoRouteArgs(
            key: key,
            organizerModel: organizerModel,
          ),
        );

  static const String name = 'OrganizerInfoRoute';
}

class OrganizerInfoRouteArgs {
  const OrganizerInfoRouteArgs({
    this.key,
    required this.organizerModel,
  });

  final Key? key;

  final OrganizerModel organizerModel;

  @override
  String toString() {
    return 'OrganizerInfoRouteArgs{key: $key, organizerModel: $organizerModel}';
  }
}

/// generated route for
/// [EventInfoPage]
class EventInfoRoute extends PageRouteInfo<EventInfoRouteArgs> {
  EventInfoRoute({
    Key? key,
    required Event? event,
  }) : super(
          EventInfoRoute.name,
          path: '/event-info-page',
          args: EventInfoRouteArgs(
            key: key,
            event: event,
          ),
        );

  static const String name = 'EventInfoRoute';
}

class EventInfoRouteArgs {
  const EventInfoRouteArgs({
    this.key,
    required this.event,
  });

  final Key? key;

  final Event? event;

  @override
  String toString() {
    return 'EventInfoRouteArgs{key: $key, event: $event}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home-page',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [DiscoveryPage]
class DiscoveryRoute extends PageRouteInfo<void> {
  const DiscoveryRoute({List<PageRouteInfo>? children})
      : super(
          DiscoveryRoute.name,
          path: 'discovery-page',
          initialChildren: children,
        );

  static const String name = 'DiscoveryRoute';
}

/// generated route for
/// [AddEventPage]
class AddEventRoute extends PageRouteInfo<AddEventRouteArgs> {
  AddEventRoute({Key? key})
      : super(
          AddEventRoute.name,
          path: 'add-event-page',
          args: AddEventRouteArgs(key: key),
        );

  static const String name = 'AddEventRoute';
}

class AddEventRouteArgs {
  const AddEventRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AddEventRouteArgs{key: $key}';
  }
}

/// generated route for
/// [TicketPage]
class TicketRoute extends PageRouteInfo<void> {
  const TicketRoute()
      : super(
          TicketRoute.name,
          path: 'ticket-page',
        );

  static const String name = 'TicketRoute';
}

/// generated route for
/// [UserPage]
class UserRoute extends PageRouteInfo<void> {
  const UserRoute()
      : super(
          UserRoute.name,
          path: 'user-page',
        );

  static const String name = 'UserRoute';
}

/// generated route for
/// [OrganizerMapPage]
class OrganizerMapRoute extends PageRouteInfo<OrganizerMapRouteArgs> {
  OrganizerMapRoute({
    Key? key,
    required List<OrganizerModel> organizerdata,
    required LatLng? currentPosition,
  }) : super(
          OrganizerMapRoute.name,
          path: 'organizer-map-page',
          args: OrganizerMapRouteArgs(
            key: key,
            organizerdata: organizerdata,
            currentPosition: currentPosition,
          ),
        );

  static const String name = 'OrganizerMapRoute';
}

class OrganizerMapRouteArgs {
  const OrganizerMapRouteArgs({
    this.key,
    required this.organizerdata,
    required this.currentPosition,
  });

  final Key? key;

  final List<OrganizerModel> organizerdata;

  final LatLng? currentPosition;

  @override
  String toString() {
    return 'OrganizerMapRouteArgs{key: $key, organizerdata: $organizerdata, currentPosition: $currentPosition}';
  }
}

/// generated route for
/// [OrganizerListPage]
class OrganizerListRoute extends PageRouteInfo<OrganizerListRouteArgs> {
  OrganizerListRoute({
    Key? key,
    required List<OrganizerModel> organizerdata,
  }) : super(
          OrganizerListRoute.name,
          path: 'organizer-list-page',
          args: OrganizerListRouteArgs(
            key: key,
            organizerdata: organizerdata,
          ),
        );

  static const String name = 'OrganizerListRoute';
}

class OrganizerListRouteArgs {
  const OrganizerListRouteArgs({
    this.key,
    required this.organizerdata,
  });

  final Key? key;

  final List<OrganizerModel> organizerdata;

  @override
  String toString() {
    return 'OrganizerListRouteArgs{key: $key, organizerdata: $organizerdata}';
  }
}
