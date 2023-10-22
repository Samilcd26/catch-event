// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:threego/app/app_router.dart';
import 'package:threego/core/SubWidgets/cached_network_image.dart';
import 'package:threego/core/SubWidgets/stack.dart';
import 'package:threego/core/SubWidgets/text.dart';

import '../../../Data/Models/organizer_model.dart';
import '../../../Data/State/organizer_cubit.dart';

@RoutePage()
class EventInfoPage extends StatelessWidget {
  EventInfoPage({super.key, required this.event});
  Event? event;
  OrganizerModel? organizerModel;
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    context.read<OrganizerCubit>().getOrganizerById(event!.organizerId!);
    organizerModel = context.read<OrganizerCubit>().currentOrganizer;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,

              flexibleSpace: FlexibleSpaceBar(background: CachedImageProvider(imageUrl: event!.imageUrl.toString())),

              // flexibleSpace: ,
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        //Event İmage

                        //Info texts
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              HeadSmallText(text: event!.title.toString()),
                              KeyValueText(
                                  visible: true,
                                  title: "Date",
                                  discript: DateFormat.MMMMd("tr").format(event!.eventDateTime!.first).toString()),
                              KeyValueText(visible: true, title: "Status", discript: event!.status.toString()),
                              KeyValueText(
                                  visible: event!.type == "EVENT",
                                  title: "Ticket Need",
                                  discript: event!.ticketNeed! ? "Bilet Gerekli" : "Bilet Gereksiz"),
                              KeyValueText(visible: true, title: "Event Platform", discript: event!.eventPlatform.toString()),
                              KeyValueText(
                                  visible: event!.type == "EVENT",
                                  title: "Capacity",
                                  discript: event!.capacity == 0 ? "∞" : event!.capacity.toString()),
                              KeyValueText(
                                  visible: event!.type == "EVENT",
                                  title: "Category",
                                  discript: event!.type == "NOTIFICATION" ? "Bildirim" : event!.category.toString()),
                              KeyValueText(
                                  visible: event!.type == "EVENT",
                                  title: "Fiyat",
                                  discript: event!.price == 0 ? "Free" : event!.price.toString()),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(height: 50),
                  ListTile(
                    title: const Text("Açıklama"),
                    subtitle: ReadMoreText(event!.description.toString(), trimLines: 3),
                  ),
                  const Divider(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          //Event Star rated
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [HeadSmallText(text: "4"), const SizedBox(width: 10), const Icon(Icons.thumb_up_off_alt_rounded)],
                              ),
                              Row(
                                children: [HeadSmallText(text: "4"), const SizedBox(width: 10), const Icon(Icons.thumb_down_alt_rounded)],
                              ),
                            ],
                          )),
                          const VerticalDivider(color: Colors.red, width: 20),

                          Expanded(
                              child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite),
                            label: const Text("add"),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(const StadiumBorder()),
                                backgroundColor: const MaterialStatePropertyAll(Colors.black)),
                          )),
                        ],
                      ),
                    ),
                  ),

                  const Divider(),
                  //Partner list
                  event!.eventPartners != null ? HeadSmallText(text: "Katılımcılar") : const SizedBox(),
                  event!.eventPartners != null
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                //Event partners list
                                children: event!.eventPartners!
                                    .map((partner) => SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.3,
                                          height: MediaQuery.of(context).size.height * 0.2,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: ImageCard(
                                                  imageUrl: partner.imageUrl.toString(),
                                                  text: partner.name.toString(),
                                                ),
                                              )
                                            ],
                                          ),
                                        ))
                                    .toList()),
                          ),
                        )
                      : const SizedBox(height: 80),
                  const Divider(height: 80),
                  HeadSmallText(text: "Organizatör"),
                  organizerModel!.image != null
                      ? ListTile(
                          leading: CircleAvatar(backgroundImage: NetworkImage(organizerModel!.image.toString())),
                          title: Text(organizerModel!.title.toString()),
                          subtitle: ReadMoreText(
                            organizerModel!.description.toString(),
                            trimLength: 60,
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                AutoRouter.of(context).push(OrganizerInfoRoute(organizerModel: organizerModel!));
                              },
                              icon: const Icon(Icons.arrow_forward_ios_rounded)),
                        )
                      : const SizedBox(),
                  const Divider(height: 80),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
