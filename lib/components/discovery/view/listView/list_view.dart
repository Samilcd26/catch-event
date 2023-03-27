import 'package:flutter/material.dart';

import '../../../../Data/Models/publisher_model.dart';

class PublisherListPage extends StatelessWidget {
  PublisherListPage({super.key, required this.publisherdata});
  late final List<PublisherModel> publisherdata;

  //final GmapViewModel gmapViewModel = GmapViewModel(PublisherService(NetworkProduct.instance.networkManager));
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
            itemCount: publisherdata.length,
            itemBuilder: (context, pIndex) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    //Publisher title
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.green.shade300,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(publisherdata[pIndex].brand.toString()),
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
                        itemCount: publisherdata[pIndex].event == null ? 0 : publisherdata[pIndex].event!.length,
                        itemBuilder: (context, eIndex) {
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
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(publisherdata[pIndex].event![eIndex].image.toString()),
                                                fit: BoxFit.cover)),
                                      ),
                                      Divider(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(publisherdata[pIndex].event![eIndex].title.toString(),
                                                    style: Theme.of(context).textTheme.bodyLarge),
                                              ],
                                            ),
                                            const SizedBox(height: 10),

                                            //Adress Icon+text
                                            const InfoIconText(
                                              text: "Adressdasdasd",
                                              icon: Icons.location_pin,
                                            ),
                                            const SizedBox(height: 5),

                                            //Adress Icon+Date
                                            Row(
                                              children: [const Icon(Icons.date_range_outlined), Text("06/10/2023")],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [const Icon(Icons.attach_money), Text("200TL")],
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
                        },
                      ),
                    )
                  ],
                ),
              );
            }));
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
