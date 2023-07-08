import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../../Data/Models/organizer_model.dart';
import '../../../../Data/State/account_cubit.dart';
import '../../../../core/product/helper/loading_animation.dart';
import '../../../../core/product/helper/text.dart';
import '../../../../core/product/navigator/app_router.dart';

@RoutePage()
class OrganizerListPage extends StatefulWidget {
  OrganizerListPage({super.key, required this.organizerdata, required this.parentContex});
  late final List<OrganizerModel> organizerdata;
  final BuildContext parentContex;

  @override
  State<OrganizerListPage> createState() => _OrganizerListPageState();
}

class _OrganizerListPageState extends State<OrganizerListPage> {
  @override
  Widget build(BuildContext context) {
    var accountState = widget.parentContex.read<AccountCubit>();
    List<Event>? eventList = accountState.events;
    initializeDateFormatting();

    return Scaffold(
        body: BlocListener(
      bloc: BlocProvider.of<AccountCubit>(widget.parentContex)..changeState,
      listener: (context, state) {
        eventList = widget.parentContex.read<AccountCubit>().events;
        setState(() {});
      },
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 200,
            // flexibleSpace: ,
          ),
          SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //Card height
                childAspectRatio: 0.65,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: eventList!.length,
                (context, index) {
                  return EventInfoCard(
                    globalContex: context,
                    event: eventList![index],
                  );
                },
              ))
        ],
      ),
    ));
  }
}

// ignore: must_be_immutable
class EventInfoCard extends StatelessWidget {
  EventInfoCard({super.key, required this.event, required this.globalContex});
  BuildContext globalContex;
  Event? event;

  @override
  Widget build(BuildContext context) {
    return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: () {
            AutoRouter.of(context).push(EventInfoRoute(event: event));
          },
          child: Column(
            children: [
              //Event Image
              CachedNetworkImage(
                //event!.imageUrl ?? "https://arctype.com/blog/content/images/2021/04/NULL.jpg"
                imageUrl: "https://arctype.com/blog/content/images/2021/04/NULL.jpg",
                placeholder: (context, url) => const ImageLoadAnimation(),
                height: 100,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            event!.title.toString(),
                            style: Theme.of(context).textTheme.bodyLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    //Adress Icon+text
                    InfoIconText(
                      text: event!.address!.isNotEmpty ? "${event!.address![0].city}" : "Online",
                      icon: Icons.location_pin,
                    ),
                    const SizedBox(height: 5),
                    KeyValueText(visible: true, title: "Date", discript: DateFormat.MMMMd("tr").format(event!.eventDateTime!.first)),
                    KeyValueText(visible: true, title: "Şart", discript: "+18"),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(event!.price.toString()),
                        SizedBox(width: 80, child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.send), label: Text("6km")))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class InfoIconText extends StatelessWidget {
  const InfoIconText({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 10,
        ),
        Text(text)
      ],
    );
  }
}


/*return EventInfoCard(
                            eventAddress: organizerdata[pIndex].event![eIndex].address,
                            eventDates: organizerdata[pIndex].event![eIndex].eventDateTime,
                            eventPrice: organizerdata[pIndex].event![eIndex].price,
                            eventTitle: organizerdata[pIndex].event![eIndex].title,
                            imageUrl: organizerdata[pIndex].event![eIndex].imageUrl,
                          ); */