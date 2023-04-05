import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../../Data/Models/organizer_model.dart';
import '../../../../Data/State/root_cubit.dart';
import '../../../../core/product/helper/text.dart';
import '../../../../core/product/navigator/app_router.dart';

class OrganizerListPage extends StatelessWidget {
  OrganizerListPage({super.key, required this.organizerdata});
  late final List<OrganizerModel> organizerdata;

  //final GmapViewModel gmapViewModel = GmapViewModel(OrganizerService(NetworkProduct.instance.networkManager));
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    List<Event>? eventList = context.read<RootCubit>().events;
    return Scaffold(
        body: CustomScrollView(
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
                  event: eventList[index],
                );
              },
            ))
      ],
    ));
  }
}

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

              Container(
                height: 100,
                color: Colors.redAccent,
                //decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover)),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(event!.title.toString(), style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                    const SizedBox(height: 10),

                    //Adress Icon+text
                    InfoIconText(
                      text: event!.address!.isNotEmpty ? "${event!.address![0].city}" : "Online",
                      icon: Icons.location_pin,
                    ),
                    const SizedBox(height: 5),
                    KeyValueText(title: "Date", discript: DateFormat.MMMMd("tr").format(event!.eventDateTime!.first)),
                    KeyValueText(title: "title", discript: "discript"),
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