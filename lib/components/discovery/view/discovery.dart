import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../Data/State/organizer_cubit.dart';
import '../../../Data/State/root_cubit.dart';
import '../../../business/services/impl/OrganizerService.dart';
import '../../../core/product/helper/loading_animation.dart';
import '../../../core/product/navigator/app_router.dart';
import '../../../core/product/services/network_service.dart';

class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({super.key});

  @override
  Widget build(BuildContext Gcontext) {
    Gcontext.read<RootCubit>().loadingInitData();

    return Gcontext.watch<RootCubit>().isLoading
        ? AutoTabsRouter.tabBar(
            routes: [
              //OrganizerMapPage
              OrganizerMapRoute(
                  organizerdata: Gcontext.read<RootCubit>().organizerData, currentPosition: Gcontext.read<RootCubit>().cordinate),
              //OrganizerListPage
              OrganizerListRoute(organizerdata: Gcontext.read<RootCubit>().organizerData)
            ],
            physics: const NeverScrollableScrollPhysics(),
            builder: (context, child, tabController) {
              return BlocProvider(
                  create: (context) => OrganizerCubit(
                        organizerService: OrganizerService(NetworkService.instance.networkManager),
                      ),
                  child: _discoveryNaviBar(
                    gcontex: Gcontext,
                    child: child,
                  ));
            },
          )
        : const LoadingBar();
  }
}

class _discoveryNaviBar extends StatelessWidget {
  const _discoveryNaviBar({required this.child, required this.gcontex});
  final BuildContext gcontex;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          child,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.black,
                    ),
                    width: MediaQuery.of(context).size.width * 0.22,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: GNav(
                      tabBorderRadius: 50,
                      color: Colors.white60,
                      activeColor: Colors.white,
                      tabBackgroundColor: Colors.grey.shade900,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      tabs: [
                        //
                        GButton(
                          icon: Icons.home_filled,
                          onPressed: () {
                            context.tabsRouter.setActiveIndex(_pageList.Map.index);
                          },
                        ),
                        GButton(
                          icon: Icons.explore_outlined,
                          onPressed: () {
                            context.tabsRouter.setActiveIndex(_pageList.List.index);
                          },
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        AutoRouter.of(context).push(FilterRoute());
                      },
                      icon: Icon(Icons.filter_list_rounded))
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}

enum _pageList { Map, List }
