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
    PublisherInfoRoute.name: (routeData) {
      final args = routeData.argsAs<PublisherInfoRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: PublisherInfoPage(
          key: args.key,
          publisherModel: args.publisherModel,
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
    PublisherMapRoute.name: (routeData) {
      final args = routeData.argsAs<PublisherMapRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: PublisherMapPage(
          key: args.key,
          publisherdata: args.publisherdata,
          currentPosition: args.currentPosition,
        ),
      );
    },
    PublisherListRoute.name: (routeData) {
      final args = routeData.argsAs<PublisherListRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: PublisherListPage(
          key: args.key,
          publisherdata: args.publisherdata,
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
                  PublisherMapRoute.name,
                  path: 'publisher-map-page',
                  parent: DiscoveryRoute.name,
                ),
                RouteConfig(
                  PublisherListRoute.name,
                  path: 'publisher-list-page',
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
          PublisherInfoRoute.name,
          path: '/publisher-info-page',
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
/// [PublisherInfoPage]
class PublisherInfoRoute extends PageRouteInfo<PublisherInfoRouteArgs> {
  PublisherInfoRoute({
    Key? key,
    required PublisherModel publisherModel,
  }) : super(
          PublisherInfoRoute.name,
          path: '/publisher-info-page',
          args: PublisherInfoRouteArgs(
            key: key,
            publisherModel: publisherModel,
          ),
        );

  static const String name = 'PublisherInfoRoute';
}

class PublisherInfoRouteArgs {
  const PublisherInfoRouteArgs({
    this.key,
    required this.publisherModel,
  });

  final Key? key;

  final PublisherModel publisherModel;

  @override
  String toString() {
    return 'PublisherInfoRouteArgs{key: $key, publisherModel: $publisherModel}';
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
/// [PublisherMapPage]
class PublisherMapRoute extends PageRouteInfo<PublisherMapRouteArgs> {
  PublisherMapRoute({
    Key? key,
    required List<PublisherModel> publisherdata,
    required LatLng? currentPosition,
  }) : super(
          PublisherMapRoute.name,
          path: 'publisher-map-page',
          args: PublisherMapRouteArgs(
            key: key,
            publisherdata: publisherdata,
            currentPosition: currentPosition,
          ),
        );

  static const String name = 'PublisherMapRoute';
}

class PublisherMapRouteArgs {
  const PublisherMapRouteArgs({
    this.key,
    required this.publisherdata,
    required this.currentPosition,
  });

  final Key? key;

  final List<PublisherModel> publisherdata;

  final LatLng? currentPosition;

  @override
  String toString() {
    return 'PublisherMapRouteArgs{key: $key, publisherdata: $publisherdata, currentPosition: $currentPosition}';
  }
}

/// generated route for
/// [PublisherListPage]
class PublisherListRoute extends PageRouteInfo<PublisherListRouteArgs> {
  PublisherListRoute({
    Key? key,
    required List<PublisherModel> publisherdata,
  }) : super(
          PublisherListRoute.name,
          path: 'publisher-list-page',
          args: PublisherListRouteArgs(
            key: key,
            publisherdata: publisherdata,
          ),
        );

  static const String name = 'PublisherListRoute';
}

class PublisherListRouteArgs {
  const PublisherListRouteArgs({
    this.key,
    required this.publisherdata,
  });

  final Key? key;

  final List<PublisherModel> publisherdata;

  @override
  String toString() {
    return 'PublisherListRouteArgs{key: $key, publisherdata: $publisherdata}';
  }
}
