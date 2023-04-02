import 'package:flutter/material.dart';

import '../../../../Data/Models/organizer_model.dart';

class OrganizerListPage extends StatelessWidget {
  OrganizerListPage({super.key, required this.organizerdata});
  late final List<OrganizerModel> organizerdata;

  //final GmapViewModel gmapViewModel = GmapViewModel(OrganizerService(NetworkProduct.instance.networkManager));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: organizerdata.length,
            itemBuilder: (context, pIndex) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    //Organizer title
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.green.shade300,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(organizerdata[pIndex].title.toString()),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: organizerdata[pIndex].event == null ? 0 : organizerdata[pIndex].event!.length,
                        itemBuilder: (context, eIndex) {
                          return EventInfoCard(
                            eventAddress: organizerdata[pIndex].event![eIndex].address,
                            eventDates: organizerdata[pIndex].event![eIndex].eventDateTime,
                            eventPrice: organizerdata[pIndex].event![eIndex].price,
                            eventTitle: organizerdata[pIndex].event![eIndex].title,
                            imageUrl: organizerdata[pIndex].event![eIndex].imageUrl,
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}

class EventInfoCard extends StatelessWidget {
  EventInfoCard(
      {super.key,
      required this.eventAddress,
      required this.eventDates,
      required this.eventPrice,
      required this.eventTitle,
      required this.imageUrl});

  String? imageUrl;
  String? eventTitle;
  List<Address>? eventAddress;
  List<DateTime>? eventDates;
  double? eventPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: [
                //Event Image
                Container(
                  height: 100,
                  decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover)),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(eventTitle!, style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                      const SizedBox(height: 10),

                      //Adress Icon+text
                      InfoIconText(
                        text: "${eventAddress![0].city}",
                        icon: Icons.location_pin,
                      ),
                      const SizedBox(height: 5),

                      //Adress Icon+Date
                      Row(
                        children: [const Icon(Icons.date_range_outlined), Text(eventDates!.first.day.toString())],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [const Icon(Icons.attach_money), Text(eventPrice.toString())],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
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
