import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmore/readmore.dart';

import '../../../../Data/Models/category_model.dart';
import '../../../../Data/Models/publisher_model.dart';
import '../../../../core/product/helper/dividers.dart';
import '../../../../core/product/helper/elevated_button.dart';
import '../../../../core/product/helper/loading_animation.dart';
import '../listView/list_view.dart';

class PublisherMapPage extends StatefulWidget {
  PublisherMapPage({super.key, required this.publisherdata, required this.currentPosition});

  late final List<PublisherModel> publisherdata;
  LatLng? currentPosition;
  //final GmapViewModel gmapViewModel = GmapViewModel(PublisherService(NetworkService.instance.networkManager));
  @override
  State<PublisherMapPage> createState() => _PublisherMapPageState();
}

class _PublisherMapPageState extends State<PublisherMapPage> {
  List<Marker> _markerList = [];
  bool isLoading = false;
  ////////////////////////////////
  @override
  void initState() {
    loadingMarkerData();
    super.initState();
  }

  /////////////////////////////////////////////////////////////////
  /// Main widget /////////////////////////////////////////////////P
  @override
  Widget build(BuildContext context) {
    return widget.currentPosition!.latitude != 0
        ? Stack(
            children: [
              //Google Maps Widgets
              GoogleMap(
                myLocationEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(target: widget.currentPosition!, zoom: 14),
                markers: Set.of(_markerList),
                indoorViewEnabled: false,
                mapToolbarEnabled: false,
                zoomControlsEnabled: false,
                buildingsEnabled: false,
                myLocationButtonEnabled: true,
                tiltGesturesEnabled: false,
              ),

              //Filter Button
              Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.1,
                  right: MediaQuery.of(context).size.width * 0.02,
                  child: CircleAvatar(
                    child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Filters:",
                                        style: Theme.of(context).textTheme.titleSmall,
                                      ),
                                      const SizedBox(height: 20),
                                      Wrap(
                                        children: allCategoryList
                                            .expand((category) => {
                                                  ElevatedButton.icon(
                                                    icon: Icon(category.icon),
                                                    label: Text(category.name.toString()),
                                                    style: ButtonStyle(
                                                        backgroundColor: MaterialStatePropertyAll<Color>(
                                                            category.onSelect! ? Colors.green : category.color!)),
                                                    onPressed: () {
                                                      setState(() {
                                                        category.onSelect = !category.onSelect!;
                                                        category.onSelect!
                                                            ? selectedCategory.add(category)
                                                            : selectedCategory.remove(category);
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(width: 10)
                                                })
                                            .toList(),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        icon: const Icon(Icons.filter_alt_outlined)),
                  ))
            ],
          )
        : const LoadingBar();
  }

//Markers
  loadingMarkerData() async {
    List emty = [];
    Uint8List customMarker;
    await Future.wait(widget.publisherdata.map((publisherElement) async => {
          Future.wait(publisherElement.event!.map((eventItem) async => {
                Future.wait(eventItem.address!.map((eventAdress) async => {
                      customMarker = await getBytesFromAsset(eventItem.category.toString(), 150),
                      //
                      _markerList.add(Marker(
                        markerId: MarkerId(eventAdress.coordinate!.latitude.toString()),
                        icon: BitmapDescriptor.fromBytes(customMarker),
                        position: eventAdress.coordinate!.toLatLng(),
                        infoWindow: InfoWindow(title: eventItem.category.toString()),
                        consumeTapEvents: false,
                        onTap: () {
                          showBottomSheet(
//
                              backgroundColor: const Color.fromARGB(255, 235, 235, 235),
                              context: context,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                              builder: (context) {
                                return Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                                  //Divider
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: NetworkImage(eventItem.image.toString()), fit: BoxFit.cover)),
                                    child: Column(mainAxisAlignment: MainAxisAlignment.start, children: const [
                                      //Divider
                                      CustomDivider()
                                    ]),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [Text(eventItem.title.toString(), style: Theme.of(context).textTheme.headlineSmall)],
                                      ),

                                      /////////////////////////////////////////////////////
                                      ///go location icon/////////////////////////////////////
                                      const GoLocationBtn(
                                        iconData: Icons.navigation_rounded,
                                        text: "6km\n5Dk",
                                      ),
                                    ],
                                  ),

                                  Column(
                                    children: [InfoIconText(text: "Konser", icon: Icons.local_activity)],
                                  ),

                                  ListTile(
                                    title: Text('Etkinlik Detayı'),
                                    subtitle: ReadMoreText(
                                      eventItem.description.toString(),
                                      trimLines: 1,
                                    ),
                                  )
//Event list card widget
                                ]);
                              });
                        },
                      )),
                      setState(() {})
                    })),
              }))
        }));

    _changeLoadingStatus();
  }

  void _changeLoadingStatus() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    String categoryPath = "";

    switch (path) {
      case "FOOD":
        categoryPath = 'assets/markers/FOOD.png';
        break;

      case "CULTURAL":
        categoryPath = 'assets/markers/CULTURAL.png';
        break;

      case "TOURISTY":
        categoryPath = 'assets/markers/TOURISTY.png';
        break;

      case "SHOOP":
        categoryPath = 'assets/markers/SHOOP.png';
        break;

      case "CHARITABLE":
        categoryPath = 'assets/markers/CHARITABLE.png';
        break;

      case "COMPETITION":
        categoryPath = 'assets/markers/COMPETITION.png';
        break;

      case "RELIGIOUS":
        categoryPath = 'assets/markers/RELIGIOUS.png';
        break;
      case "ART":
        categoryPath = 'assets/markers/ART.png';
        break;
      case "BUSINESS":
        categoryPath = 'assets/markers/BUSINESS.png';
        break;

      case "EDUCATION":
        categoryPath = 'assets/markers/EDUCATION.png';
        break;
      case "MUSIC":
        categoryPath = 'assets/markers/MUSIC.png';
        break;
      default:
    }
    //'assets/markers/test.png'
    ByteData data = await rootBundle.load(categoryPath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}

enum PublisherCategories {
  FOOD,
  CULTURAL,
  TOURISTY,
  SHOOP,
  CHARITABLE,
  COMPETITION,
  RELIGIOUS,
  ART,
  BUSINESS,
  EDUCATION,
  MUSIC,
}

List<CategoryModel> allCategoryList = [
  CategoryModel(PublisherCategories.FOOD.name, Icons.lunch_dining_rounded, false, Colors.amber),
  CategoryModel(PublisherCategories.CULTURAL.name, Icons.theater_comedy_rounded, false, Colors.purple),
  CategoryModel(PublisherCategories.TOURISTY.name, Icons.beach_access, false, Colors.blueGrey),
  CategoryModel(PublisherCategories.SHOOP.name, Icons.shopping_bag_rounded, false, Colors.cyan),
  CategoryModel(PublisherCategories.CHARITABLE.name, Icons.handshake_rounded, false, Colors.red),
  CategoryModel(PublisherCategories.COMPETITION.name, Icons.emoji_events_rounded, false, Colors.blueAccent),
  CategoryModel(PublisherCategories.RELIGIOUS.name, Icons.mosque_rounded, false, Colors.black54),
];

List<CategoryModel> selectedCategory = [];
