import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

import '../../../Data/Models/publisher_model.dart';
import '../../../Data/State/root_cubit.dart';
import '../../../core/product/helper/loading_animation.dart';
import '../../../core/product/navigator/app_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //InitData
    context.read<RootCubit>().loadingInitData();
    context.read<RootCubit>().isLoading ? inspect(context.read<RootCubit>().currentUser) : inspect("object");

    bool isSearch = false;

    return context.watch<RootCubit>().isLoading
        ? SafeArea(
            child: NestedScrollView(
                headerSliverBuilder: ((context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: Colors.black,
                      leading: Image.asset("assets/logo.png"),
                      //shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            showSearch(context: context, delegate: SearchBar(ccontex: context));
                          },
                        ),
                        IconButton(onPressed: () {}, icon: _notificationIcon(counter: 2)),
                      ],
                      titleSpacing: MediaQuery.of(context).size.width * 0.7,
                    ),
                  ];
                }),
                body: ListView.builder(
                    itemCount: context.read<RootCubit>().followPublisherList!.length,
                    itemBuilder: ((context, index) {
                      return Column(
                        children: context
                            .read<RootCubit>()
                            .followPublisherList![index]
                            .event!
                            .map((eventList) => Column(
                                  children: [
                                    //Card Title
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child: Text(context.read<RootCubit>().followPublisherList![index].brand.toString())),
                                          Expanded(
                                            child: CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(context.read<RootCubit>().followPublisherList![index].image.toString()),
                                            ),
                                          ),
                                          const Expanded(child: SizedBox()),
                                        ],
                                      ),
                                    ),
                                    //event ımage

                                    Image.network(eventList.image.toString()),
                                    //Event actions buttons
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          children: [
                                            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_rounded)),
                                            IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
                                            IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                                          ],
                                        ),
                                        IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_add))
                                      ],
                                    ),

                                    //Event Description
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: ReadMoreText(
                                        eventList.description.toString(),
                                        trimLines: 2,
                                        colorClickableText: Colors.pink,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: 'Show more',
                                        trimExpandedText: 'Show less',
                                      ),
                                    ),
                                    //Event Commants List
                                    TextButton(onPressed: () {}, child: Text("288 Yorumun Tümü gör")),
                                    const Divider()
                                  ],
                                ))
                            .toList(),
                      );
                    }))))
        : const LoadingBar();
  }
}

class SearchBar extends SearchDelegate {
  SearchBar({required this.ccontex});
  BuildContext ccontex;

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = '';
        }
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //Cancel bottun
    IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Onay Butonu
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<PublisherModel>? searchList = [];
    ccontex.read<RootCubit>().searchPublisher(query);

    searchList = ccontex.read<RootCubit>().searchList;
    if (searchList!.isNotEmpty) {
      return ListView.builder(
          itemCount: searchList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(searchList![index].image.toString())),
              title: Text(searchList![index].brand.toString()),
              subtitle: const Text("20000 Takipçi"),
              onTap: () {
                context.router.push(PublisherInfoRoute(publisherModel: searchList![index]));
              },
            );
          });
    } else {
      return const Divider();
    }
  }
}

class _notificationIcon extends StatelessWidget {
  _notificationIcon({super.key, required this.counter});

  int counter;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Stack(
        children: [
          const Icon(
            Icons.notifications,
            color: Colors.white,
            size: 30,
          ),
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(top: 5),
            child: Container(
              width: 15,
              height: 15,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: const Color(0xffc32c37), border: Border.all(color: Colors.white, width: 1)),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Center(
                  child: Text(
                    counter.toString(),
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
