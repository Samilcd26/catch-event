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
  const DiscoveryPage({super.key, required this.parentContex});
  final BuildContext parentContex;

  @override
  Widget build(BuildContext Gcontext) {
    var _rootState = parentContex.read<RootCubit>();

    return _rootState.isLoading
        ? AutoTabsRouter.tabBar(
            routes: [
              //?OrganizerMapPage
              OrganizerMapRoute(organizerdata: _rootState.organizerData, parentContex: parentContex),
              //?OrganizerListPage
              OrganizerListRoute(organizerdata: _rootState.organizerData, parentContex: parentContex)
            ],
            physics: const NeverScrollableScrollPhysics(),
            builder: (context, child, tabController) {
              return BlocProvider(
                  create: (context) => OrganizerCubit(
                        organizerService: OrganizerService(NetworkService.instance.networkManager),
                      ),
                  child: _discoveryNaviBar(
                    parent2Contex: parentContex,
                    gcontex: Gcontext,
                    child: child,
                  ));
            },
          )
        : const LoadingBar();
  }
}

class _discoveryNaviBar extends StatefulWidget {
  const _discoveryNaviBar({required this.child, required this.gcontex, required this.parent2Contex});
  final BuildContext gcontex;
  final BuildContext parent2Contex;
  final Widget child;

  @override
  State<_discoveryNaviBar> createState() => _discoveryNaviBarState();
}

class _discoveryNaviBarState extends State<_discoveryNaviBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          widget.child,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  //! Add new Addressing
                  IconButton(
                      onPressed: () async {
                        await AutoRouter.of(context).push(SearchLocationRoute(isChangeCurrentLocation: true));
                        setState(() {});
                      },
                      icon: const Icon(Icons.public)),
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
                        AutoRouter.of(context).push(FilterRoute(parentContex: widget.parent2Contex));
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
