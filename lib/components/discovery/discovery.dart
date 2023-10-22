import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:threego/app/app_router.dart';
import 'package:threego/core/SubWidgets/loading_animation.dart';

import '../../../Data/State/account_cubit.dart';

@RoutePage()
class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({super.key, required this.parentContex});
  final BuildContext parentContex;

  @override
  Widget build(BuildContext context) {
    var accountState = parentContex.read<AccountCubit>();

    return accountState.isLoading
        ? AutoTabsRouter.tabBar(
            routes: [
              //?OrganizerMapPage
              OrganizerMapRoute(parentContex: parentContex),
              //?OrganizerListPage
              OrganizerListRoute(parentContex: parentContex)
            ],
            physics: const NeverScrollableScrollPhysics(),
            builder: (context, child, tabController) {
              return DiscoveryNaviBar(
                parent2Contex: parentContex,
                gcontex: context,
                child: child,
              );
            },
          )
        : const LoadingBar();
  }
}

class DiscoveryNaviBar extends StatefulWidget {
  const DiscoveryNaviBar({super.key, required this.child, required this.gcontex, required this.parent2Contex});
  final BuildContext gcontex;
  final BuildContext parent2Contex;
  final Widget child;

  @override
  State<DiscoveryNaviBar> createState() => DiscoveryNaviBarState();
}

class DiscoveryNaviBarState extends State<DiscoveryNaviBar> {
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
                            context.tabsRouter.setActiveIndex(PageList.Map.index);
                          },
                        ),
                        GButton(
                          icon: Icons.explore_outlined,
                          onPressed: () {
                            context.tabsRouter.setActiveIndex(PageList.List.index);
                          },
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        AutoRouter.of(context).push(FilterRoute(parentContex: widget.parent2Contex));
                      },
                      icon: const Icon(Icons.filter_list_rounded))
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}

// ignore: constant_identifier_names
enum PageList { Map, List }
