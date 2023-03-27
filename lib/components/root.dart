import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../Data/State/root_cubit.dart';
import '../business/services/impl/AccountService.dart';
import '../business/services/impl/PublisherService.dart';
import '../core/product/navigator/app_router.dart';
import '../core/product/services/network_service.dart';

class RootPage extends StatelessWidget {
  RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool visible = false;
    return AutoTabsRouter.tabBar(
      physics: NeverScrollableScrollPhysics(),
      routes: [const HomeRoute(), const DiscoveryRoute(), AddEventRoute(), const TicketRoute(), const UserRoute()],
      builder: (context, child, tabController) {
        tabController.index;
        return Scaffold(
          body: BlocProvider(
            create: (context) => RootCubit(
                publisherService: PublisherService(NetworkService.instance.networkManager),
                accoundService: AccountService(NetworkService.instance.networkManager)),
            child: child,
          ),
          bottomNavigationBar: Container(
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
        );
      },
    );
  }
}

enum _pageList { Home, Discovery, Add, Ticket, User }
