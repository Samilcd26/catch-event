import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../Data/State/publisher_cubit.dart';
import '../../../Data/State/root_cubit.dart';
import '../../../core/product/helper/loading_animation.dart';
import '../../../core/product/navigator/app_router.dart';

class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RootCubit>().loadingInitData();

    return context.watch<RootCubit>().isLoading
        ? AutoTabsRouter.tabBar(
            routes: [
              //PublisherMapPage
              PublisherMapRoute(
                  publisherdata: context.read<RootCubit>().publisherData, currentPosition: context.read<RootCubit>().cordinate),
              //PublisherListPage
              PublisherListRoute(publisherdata: context.read<RootCubit>().publisherData)
            ],
            physics: const NeverScrollableScrollPhysics(),
            builder: (context, child, tabController) {
              return BlocProvider(
                  create: (context) => PublisherCubit(),
                  child: _discoveryNaviBar(
                    child: child,
                  ));
            },
          )
        : const LoadingBar();
  }
}

class _discoveryNaviBar extends StatelessWidget {
  const _discoveryNaviBar({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          child,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _naviBar(),
            ],
          ),
        ]),
      ),
    );
  }
}

class _naviBar extends StatelessWidget {
  const _naviBar();

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

enum _pageList { Map, List }
