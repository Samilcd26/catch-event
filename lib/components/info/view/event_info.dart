import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

import '../../../Data/Models/organizer_model.dart';
import '../../../Data/State/organizer_cubit.dart';
import '../../../core/product/helper/stack.dart';
import '../../../core/product/helper/text.dart';
import '../../../core/product/navigator/app_router.dart';

class EventInfoPage extends StatelessWidget {
  EventInfoPage({super.key, required this.event});
  Event? event;
  OrganizerModel? organizerModel;
  @override
  Widget build(BuildContext context) {
    context.read<OrganizerCubit>().getOrganizerById(event!.organizerId!);
    organizerModel = context.read<OrganizerCubit>().currentOrganizer;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              expandedHeight: 200,
              /*
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    width: 100,
                child: Image.network(event!.imageUrl.toString()),
              )),*/
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.2,
                            color: Colors.red,
                          ),
                        ),
                        //Info texts
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              children: [
                                HeadSmallText(text: event!.title.toString()),
                                KeyValueText(
                                    title: "Date", discript: DateFormat.MMMMd("tr").format(event!.eventDateTime!.first).toString()),
                                KeyValueText(title: "Status", discript: event!.status.toString()),
                                KeyValueText(title: "Ticket Need", discript: event!.ticketNeed.toString()),
                                KeyValueText(title: "Event Platform", discript: event!.eventPlatform.toString()),
                                KeyValueText(title: "Capacity", discript: event!.capacity.toString()),
                                KeyValueText(title: "Category", discript: event!.category.toString()),
                                KeyValueText(title: "Pirice", discript: event!.price.toString()),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
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
                                children: [HeadSmallText(text: "4"), Icon(Icons.star)],
                              ),
                              BodySmallText(text: "${event!.likeScore} Vote")
                            ],
                          )),
                          const VerticalDivider(color: Colors.red, width: 20),

                          Expanded(
                              child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.favorite),
                            label: Text("add"),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(const StadiumBorder()),
                                backgroundColor: const MaterialStatePropertyAll(Colors.black)),
                          )),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 50),
                  ListTile(
                    title: const Text("Açıklama"),
                    subtitle: ReadMoreText(event!.description.toString(), trimLines: 3),
                  ),
                  const Divider(),
                  //Partner list
                  HeadSmallText(text: "Katılımcılar"),
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
