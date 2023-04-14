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
    SearchLocationRoute.name: (routeData) {
      final args = routeData.argsAs<SearchLocationRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: SearchLocationPage(
          key: args.key,
          isChangeCurrentLocation: args.isChangeCurrentLocation,
        ),
      );
    },
    FilterRoute.name: (routeData) {
      final args = routeData.argsAs<FilterRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: FilterPage(
          key: args.key,
          parentContex: args.parentContex,
        ),
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
      final args = routeData.argsAs<HomeRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: HomePage(
          key: args.key,
          parentContex: args.parentContex,
        ),
      );
    },
    DiscoveryRoute.name: (routeData) {
      final args = routeData.argsAs<DiscoveryRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: DiscoveryPage(
          key: args.key,
          parentContex: args.parentContex,
        ),
      );
    },
    AddEventRoute.name: (routeData) {
      final args = routeData.argsAs<AddEventRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: AddEventPage(
          key: args.key,
          currentUser: args.currentUser,
          currentOrganizer: args.currentOrganizer,
          parentContex: args.parentContex,
        ),
      );
    },
    TicketRoute.name: (routeData) {
      final args = routeData.argsAs<TicketRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: TicketPage(
          key: args.key,
          parentContex: args.parentContex,
        ),
      );
    },
    UserRoute.name: (routeData) {
      final args = routeData.argsAs<UserRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: UserPage(
          key: args.key,
          currentUser: args.currentUser,
          parentContex: args.parentContex,
        ),
      );
    },
    OrganizerMapRoute.name: (routeData) {
      final args = routeData.argsAs<OrganizerMapRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: OrganizerMapPage(
          key: args.key,
          organizerdata: args.organizerdata,
          parentContex: args.parentContex,
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
          parentContex: args.parentContex,
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
          SearchLocationRoute.name,
          path: '/search-location-page',
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
/// [SearchLocationPage]
class SearchLocationRoute extends PageRouteInfo<SearchLocationRouteArgs> {
  SearchLocationRoute({
    Key? key,
    required bool isChangeCurrentLocation,
  }) : super(
          SearchLocationRoute.name,
          path: '/search-location-page',
          args: SearchLocationRouteArgs(
            key: key,
            isChangeCurrentLocation: isChangeCurrentLocation,
          ),
        );

  static const String name = 'SearchLocationRoute';
}

class SearchLocationRouteArgs {
  const SearchLocationRouteArgs({
    this.key,
    required this.isChangeCurrentLocation,
  });

  final Key? key;

  final bool isChangeCurrentLocation;

  @override
  String toString() {
    return 'SearchLocationRouteArgs{key: $key, isChangeCurrentLocation: $isChangeCurrentLocation}';
  }
}

/// generated route for
/// [FilterPage]
class FilterRoute extends PageRouteInfo<FilterRouteArgs> {
  FilterRoute({
    Key? key,
    required BuildContext parentContex,
  }) : super(
          FilterRoute.name,
          path: '/filter-page',
          args: FilterRouteArgs(
            key: key,
            parentContex: parentContex,
          ),
        );

  static const String name = 'FilterRoute';
}

class FilterRouteArgs {
  const FilterRouteArgs({
    this.key,
    required this.parentContex,
  });

  final Key? key;

  final BuildContext parentContex;

  @override
  String toString() {
    return 'FilterRouteArgs{key: $key, parentContex: $parentContex}';
  }
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
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    Key? key,
    required BuildContext parentContex,
  }) : super(
          HomeRoute.name,
          path: 'home-page',
          args: HomeRouteArgs(
            key: key,
            parentContex: parentContex,
          ),
        );

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    required this.parentContex,
  });

  final Key? key;

  final BuildContext parentContex;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, parentContex: $parentContex}';
  }
}

/// generated route for
/// [DiscoveryPage]
class DiscoveryRoute extends PageRouteInfo<DiscoveryRouteArgs> {
  DiscoveryRoute({
    Key? key,
    required BuildContext parentContex,
    List<PageRouteInfo>? children,
  }) : super(
          DiscoveryRoute.name,
          path: 'discovery-page',
          args: DiscoveryRouteArgs(
            key: key,
            parentContex: parentContex,
          ),
          initialChildren: children,
        );

  static const String name = 'DiscoveryRoute';
}

class DiscoveryRouteArgs {
  const DiscoveryRouteArgs({
    this.key,
    required this.parentContex,
  });

  final Key? key;

  final BuildContext parentContex;

  @override
  String toString() {
    return 'DiscoveryRouteArgs{key: $key, parentContex: $parentContex}';
  }
}

/// generated route for
/// [AddEventPage]
class AddEventRoute extends PageRouteInfo<AddEventRouteArgs> {
  AddEventRoute({
    Key? key,
    required UserModel? currentUser,
    required OrganizerModel? currentOrganizer,
    required BuildContext parentContex,
  }) : super(
          AddEventRoute.name,
          path: 'add-event-page',
          args: AddEventRouteArgs(
            key: key,
            currentUser: currentUser,
            currentOrganizer: currentOrganizer,
            parentContex: parentContex,
          ),
        );

  static const String name = 'AddEventRoute';
}

class AddEventRouteArgs {
  const AddEventRouteArgs({
    this.key,
    required this.currentUser,
    required this.currentOrganizer,
    required this.parentContex,
  });

  final Key? key;

  final UserModel? currentUser;

  final OrganizerModel? currentOrganizer;

  final BuildContext parentContex;

  @override
  String toString() {
    return 'AddEventRouteArgs{key: $key, currentUser: $currentUser, currentOrganizer: $currentOrganizer, parentContex: $parentContex}';
  }
}

/// generated route for
/// [TicketPage]
class TicketRoute extends PageRouteInfo<TicketRouteArgs> {
  TicketRoute({
    Key? key,
    required BuildContext parentContex,
  }) : super(
          TicketRoute.name,
          path: 'ticket-page',
          args: TicketRouteArgs(
            key: key,
            parentContex: parentContex,
          ),
        );

  static const String name = 'TicketRoute';
}

class TicketRouteArgs {
  const TicketRouteArgs({
    this.key,
    required this.parentContex,
  });

  final Key? key;

  final BuildContext parentContex;

  @override
  String toString() {
    return 'TicketRouteArgs{key: $key, parentContex: $parentContex}';
  }
}

/// generated route for
/// [UserPage]
class UserRoute extends PageRouteInfo<UserRouteArgs> {
  UserRoute({
    Key? key,
    required UserModel currentUser,
    required BuildContext parentContex,
  }) : super(
          UserRoute.name,
          path: 'user-page',
          args: UserRouteArgs(
            key: key,
            currentUser: currentUser,
            parentContex: parentContex,
          ),
        );

  static const String name = 'UserRoute';
}

class UserRouteArgs {
  const UserRouteArgs({
    this.key,
    required this.currentUser,
    required this.parentContex,
  });

  final Key? key;

  final UserModel currentUser;

  final BuildContext parentContex;

  @override
  String toString() {
    return 'UserRouteArgs{key: $key, currentUser: $currentUser, parentContex: $parentContex}';
  }
}

/// generated route for
/// [OrganizerMapPage]
class OrganizerMapRoute extends PageRouteInfo<OrganizerMapRouteArgs> {
  OrganizerMapRoute({
    Key? key,
    required List<OrganizerModel> organizerdata,
    required BuildContext parentContex,
  }) : super(
          OrganizerMapRoute.name,
          path: 'organizer-map-page',
          args: OrganizerMapRouteArgs(
            key: key,
            organizerdata: organizerdata,
            parentContex: parentContex,
          ),
        );

  static const String name = 'OrganizerMapRoute';
}

class OrganizerMapRouteArgs {
  const OrganizerMapRouteArgs({
    this.key,
    required this.organizerdata,
    required this.parentContex,
  });

  final Key? key;

  final List<OrganizerModel> organizerdata;

  final BuildContext parentContex;

  @override
  String toString() {
    return 'OrganizerMapRouteArgs{key: $key, organizerdata: $organizerdata, parentContex: $parentContex}';
  }
}

/// generated route for
/// [OrganizerListPage]
class OrganizerListRoute extends PageRouteInfo<OrganizerListRouteArgs> {
  OrganizerListRoute({
    Key? key,
    required List<OrganizerModel> organizerdata,
    required BuildContext parentContex,
  }) : super(
          OrganizerListRoute.name,
          path: 'organizer-list-page',
          args: OrganizerListRouteArgs(
            key: key,
            organizerdata: organizerdata,
            parentContex: parentContex,
          ),
        );

  static const String name = 'OrganizerListRoute';
}

class OrganizerListRouteArgs {
  const OrganizerListRouteArgs({
    this.key,
    required this.organizerdata,
    required this.parentContex,
  });

  final Key? key;

  final List<OrganizerModel> organizerdata;

  final BuildContext parentContex;

  @override
  String toString() {
    return 'OrganizerListRouteArgs{key: $key, organizerdata: $organizerdata, parentContex: $parentContex}';
  }
}
