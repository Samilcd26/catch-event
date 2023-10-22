// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddEventRoute.name: (routeData) {
      final args = routeData.argsAs<AddEventRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddEventPage(
          key: args.key,
          currentUser: args.currentUser,
          currentOrganizer: args.currentOrganizer,
          parentContex: args.parentContex,
        ),
      );
    },
    SearchLocationRoute.name: (routeData) {
      final args = routeData.argsAs<SearchLocationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SearchLocationPage(
          key: args.key,
          isChangeCurrentLocation: args.isChangeCurrentLocation,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    RegisterDetailRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterDetailPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterPage(),
      );
    },
    DiscoveryRoute.name: (routeData) {
      final args = routeData.argsAs<DiscoveryRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DiscoveryPage(
          key: args.key,
          parentContex: args.parentContex,
        ),
      );
    },
    FilterRoute.name: (routeData) {
      final args = routeData.argsAs<FilterRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FilterPage(
          key: args.key,
          parentContex: args.parentContex,
        ),
      );
    },
    OrganizerMapRoute.name: (routeData) {
      final args = routeData.argsAs<OrganizerMapRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OrganizerMapPage(
          key: args.key,
          parentContex: args.parentContex,
        ),
      );
    },
    OrganizerListRoute.name: (routeData) {
      final args = routeData.argsAs<OrganizerListRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OrganizerListPage(
          key: args.key,
          parentContex: args.parentContex,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomePage(
          key: args.key,
          parentContex: args.parentContex,
        ),
      );
    },
    EventInfoRoute.name: (routeData) {
      final args = routeData.argsAs<EventInfoRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EventInfoPage(
          key: args.key,
          event: args.event,
        ),
      );
    },
    OrganizerInfoRoute.name: (routeData) {
      final args = routeData.argsAs<OrganizerInfoRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OrganizerInfoPage(
          key: args.key,
          organizerModel: args.organizerModel,
        ),
      );
    },
    UserInfoRoute.name: (routeData) {
      final args = routeData.argsAs<UserInfoRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserInfoPage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    RootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RootPage(),
      );
    },
    TicketRoute.name: (routeData) {
      final args = routeData.argsAs<TicketRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TicketPage(
          key: args.key,
          parentContex: args.parentContex,
        ),
      );
    },
    UserRoute.name: (routeData) {
      final args = routeData.argsAs<UserRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserPage(
          key: args.key,
          currentUser: args.currentUser,
          currentOrganizer: args.currentOrganizer,
          parentContex: args.parentContex,
        ),
      );
    },
  };
}

/// generated route for
/// [AddEventPage]
class AddEventRoute extends PageRouteInfo<AddEventRouteArgs> {
  AddEventRoute({
    Key? key,
    required UserModel? currentUser,
    required OrganizerModel? currentOrganizer,
    required BuildContext parentContex,
    List<PageRouteInfo>? children,
  }) : super(
          AddEventRoute.name,
          args: AddEventRouteArgs(
            key: key,
            currentUser: currentUser,
            currentOrganizer: currentOrganizer,
            parentContex: parentContex,
          ),
          initialChildren: children,
        );

  static const String name = 'AddEventRoute';

  static const PageInfo<AddEventRouteArgs> page =
      PageInfo<AddEventRouteArgs>(name);
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
/// [SearchLocationPage]
class SearchLocationRoute extends PageRouteInfo<SearchLocationRouteArgs> {
  SearchLocationRoute({
    Key? key,
    required bool isChangeCurrentLocation,
    List<PageRouteInfo>? children,
  }) : super(
          SearchLocationRoute.name,
          args: SearchLocationRouteArgs(
            key: key,
            isChangeCurrentLocation: isChangeCurrentLocation,
          ),
          initialChildren: children,
        );

  static const String name = 'SearchLocationRoute';

  static const PageInfo<SearchLocationRouteArgs> page =
      PageInfo<SearchLocationRouteArgs>(name);
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
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterDetailPage]
class RegisterDetailRoute extends PageRouteInfo<void> {
  const RegisterDetailRoute({List<PageRouteInfo>? children})
      : super(
          RegisterDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterDetailRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
          args: DiscoveryRouteArgs(
            key: key,
            parentContex: parentContex,
          ),
          initialChildren: children,
        );

  static const String name = 'DiscoveryRoute';

  static const PageInfo<DiscoveryRouteArgs> page =
      PageInfo<DiscoveryRouteArgs>(name);
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
/// [FilterPage]
class FilterRoute extends PageRouteInfo<FilterRouteArgs> {
  FilterRoute({
    Key? key,
    required BuildContext parentContex,
    List<PageRouteInfo>? children,
  }) : super(
          FilterRoute.name,
          args: FilterRouteArgs(
            key: key,
            parentContex: parentContex,
          ),
          initialChildren: children,
        );

  static const String name = 'FilterRoute';

  static const PageInfo<FilterRouteArgs> page = PageInfo<FilterRouteArgs>(name);
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
/// [OrganizerMapPage]
class OrganizerMapRoute extends PageRouteInfo<OrganizerMapRouteArgs> {
  OrganizerMapRoute({
    Key? key,
    required BuildContext parentContex,
    List<PageRouteInfo>? children,
  }) : super(
          OrganizerMapRoute.name,
          args: OrganizerMapRouteArgs(
            key: key,
            parentContex: parentContex,
          ),
          initialChildren: children,
        );

  static const String name = 'OrganizerMapRoute';

  static const PageInfo<OrganizerMapRouteArgs> page =
      PageInfo<OrganizerMapRouteArgs>(name);
}

class OrganizerMapRouteArgs {
  const OrganizerMapRouteArgs({
    this.key,
    required this.parentContex,
  });

  final Key? key;

  final BuildContext parentContex;

  @override
  String toString() {
    return 'OrganizerMapRouteArgs{key: $key, parentContex: $parentContex}';
  }
}

/// generated route for
/// [OrganizerListPage]
class OrganizerListRoute extends PageRouteInfo<OrganizerListRouteArgs> {
  OrganizerListRoute({
    Key? key,
    required BuildContext parentContex,
    List<PageRouteInfo>? children,
  }) : super(
          OrganizerListRoute.name,
          args: OrganizerListRouteArgs(
            key: key,
            parentContex: parentContex,
          ),
          initialChildren: children,
        );

  static const String name = 'OrganizerListRoute';

  static const PageInfo<OrganizerListRouteArgs> page =
      PageInfo<OrganizerListRouteArgs>(name);
}

class OrganizerListRouteArgs {
  const OrganizerListRouteArgs({
    this.key,
    required this.parentContex,
  });

  final Key? key;

  final BuildContext parentContex;

  @override
  String toString() {
    return 'OrganizerListRouteArgs{key: $key, parentContex: $parentContex}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    Key? key,
    required BuildContext parentContex,
    List<PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            key: key,
            parentContex: parentContex,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<HomeRouteArgs> page = PageInfo<HomeRouteArgs>(name);
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
/// [EventInfoPage]
class EventInfoRoute extends PageRouteInfo<EventInfoRouteArgs> {
  EventInfoRoute({
    Key? key,
    required Event? event,
    List<PageRouteInfo>? children,
  }) : super(
          EventInfoRoute.name,
          args: EventInfoRouteArgs(
            key: key,
            event: event,
          ),
          initialChildren: children,
        );

  static const String name = 'EventInfoRoute';

  static const PageInfo<EventInfoRouteArgs> page =
      PageInfo<EventInfoRouteArgs>(name);
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
/// [OrganizerInfoPage]
class OrganizerInfoRoute extends PageRouteInfo<OrganizerInfoRouteArgs> {
  OrganizerInfoRoute({
    Key? key,
    required OrganizerModel organizerModel,
    List<PageRouteInfo>? children,
  }) : super(
          OrganizerInfoRoute.name,
          args: OrganizerInfoRouteArgs(
            key: key,
            organizerModel: organizerModel,
          ),
          initialChildren: children,
        );

  static const String name = 'OrganizerInfoRoute';

  static const PageInfo<OrganizerInfoRouteArgs> page =
      PageInfo<OrganizerInfoRouteArgs>(name);
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
/// [UserInfoPage]
class UserInfoRoute extends PageRouteInfo<UserInfoRouteArgs> {
  UserInfoRoute({
    Key? key,
    required int userId,
    List<PageRouteInfo>? children,
  }) : super(
          UserInfoRoute.name,
          args: UserInfoRouteArgs(
            key: key,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'UserInfoRoute';

  static const PageInfo<UserInfoRouteArgs> page =
      PageInfo<UserInfoRouteArgs>(name);
}

class UserInfoRouteArgs {
  const UserInfoRouteArgs({
    this.key,
    required this.userId,
  });

  final Key? key;

  final int userId;

  @override
  String toString() {
    return 'UserInfoRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [RootPage]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TicketPage]
class TicketRoute extends PageRouteInfo<TicketRouteArgs> {
  TicketRoute({
    Key? key,
    required BuildContext parentContex,
    List<PageRouteInfo>? children,
  }) : super(
          TicketRoute.name,
          args: TicketRouteArgs(
            key: key,
            parentContex: parentContex,
          ),
          initialChildren: children,
        );

  static const String name = 'TicketRoute';

  static const PageInfo<TicketRouteArgs> page = PageInfo<TicketRouteArgs>(name);
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
    required OrganizerModel currentOrganizer,
    required BuildContext parentContex,
    List<PageRouteInfo>? children,
  }) : super(
          UserRoute.name,
          args: UserRouteArgs(
            key: key,
            currentUser: currentUser,
            currentOrganizer: currentOrganizer,
            parentContex: parentContex,
          ),
          initialChildren: children,
        );

  static const String name = 'UserRoute';

  static const PageInfo<UserRouteArgs> page = PageInfo<UserRouteArgs>(name);
}

class UserRouteArgs {
  const UserRouteArgs({
    this.key,
    required this.currentUser,
    required this.currentOrganizer,
    required this.parentContex,
  });

  final Key? key;

  final UserModel currentUser;

  final OrganizerModel currentOrganizer;

  final BuildContext parentContex;

  @override
  String toString() {
    return 'UserRouteArgs{key: $key, currentUser: $currentUser, currentOrganizer: $currentOrganizer, parentContex: $parentContex}';
  }
}
