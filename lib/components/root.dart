import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:threego/business/services/impl/LocationService.dart';

import '../Data/Models/organizer_model.dart';
import '../Data/Models/user_model.dart';
import '../Data/State/account_cubit.dart';
import '../Data/State/organizer_cubit.dart';
import '../business/services/impl/AccountService.dart';
import '../business/services/impl/OrganizerService.dart';
import '../core/product/helper/loading_animation.dart';
import '../core/product/navigator/app_router.dart';
import '../core/product/services/network_service.dart';

@RoutePage()
class RootPage extends StatefulWidget {
  RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

bool isAccountDataSucces = false;

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AccountCubit>().initializ();
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel? currentUser = context.read<AccountCubit>().currentUser;

    OrganizerModel? currentOrganizer = context.read<AccountCubit>().currentOrganizer;
    context.read<OrganizerCubit>().currentOrganizer = currentOrganizer;

    isAccountDataSucces = context.watch<AccountCubit>().isLoading;
    return isAccountDataSucces == true
        ? AutoTabsRouter.tabBar(
            physics: const NeverScrollableScrollPhysics(),
            routes: [
              //! Route !!!!!
              HomeRoute(parentContex: context),
              DiscoveryRoute(parentContex: context),
              AddEventRoute(parentContex: context, currentUser: currentUser!, currentOrganizer: currentOrganizer!),
              TicketRoute(parentContex: context),
              UserRoute(parentContex: context, currentUser: currentUser, currentOrganizer: currentOrganizer)
              //!!!!!!!!!!!!!!!!
            ],
            builder: (context, child, tabController) {
              tabController.index;
              return Scaffold(
                body: BlocProvider(
                  create: (context) => AccountCubit(
                      locationService: LocationService(NetworkService.getInstance(context).networkManager),
                      organizerService: OrganizerService(NetworkService.getInstance(context).networkManager),
                      accoundService: AccountService(NetworkService.getInstance(context).networkManager)),
                  child: child,
                ),
                bottomNavigationBar: SafeArea(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: GNav(
                        backgroundColor: Colors.black,
                        color: Colors.white,
                        activeColor: Colors.white,
                        tabBackgroundColor: Colors.grey.shade900,
                        padding: EdgeInsets.all(15),
                        gap: 8,
                        tabs: [
                          //
                          GButton(
                            icon: Icons.home_filled,
                            text: "For You",
                            onPressed: () {
                              context.tabsRouter.setActiveIndex(_pageList.Home.index);
                            },
                          ),
                          GButton(
                            icon: Icons.explore_outlined,
                            text: _pageList.Discovery.name,
                            onPressed: () {
                              context.tabsRouter.setActiveIndex(_pageList.Discovery.index);
                            },
                          ),
                          GButton(
                            icon: Icons.celebration_sharp,
                            text: _pageList.Add.name,
                            onPressed: () {
                              context.tabsRouter.setActiveIndex(_pageList.Add.index);
                            },
                          ),

                          GButton(
                            icon: Icons.confirmation_number,
                            text: _pageList.Ticket.name,
                            onPressed: () {
                              context.tabsRouter.setActiveIndex(_pageList.Ticket.index);
                            },
                          ),

                          GButton(
                            icon: Icons.person_2,
                            text: _pageList.User.name,
                            onPressed: () {
                              context.tabsRouter.setActiveIndex(_pageList.User.index);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : const LoadingBar();
  }
}

// ignore: camel_case_types
enum _pageList { Home, Discovery, Add, Ticket, User }
