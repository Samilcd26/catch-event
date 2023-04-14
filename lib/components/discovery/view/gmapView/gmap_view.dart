import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmore/readmore.dart';

import '../../../../Data/Models/category_model.dart';
import '../../../../Data/Models/organizer_model.dart';
import '../../../../Data/State/root_cubit.dart';
import '../../../../core/product/helper/dividers.dart';
import '../../../../core/product/helper/elevated_button.dart';
import '../../../../core/product/helper/loading_animation.dart';
import '../listView/list_view.dart';

class OrganizerMapPage extends StatefulWidget {
  OrganizerMapPage({super.key, required this.organizerdata, required this.parentContex});
  final BuildContext parentContex;
  late final List<OrganizerModel> organizerdata;
  //final GmapViewModel gmapViewModel = GmapViewModel(OrganizerService(NetworkService.instance.networkManager));
  @override
  State<OrganizerMapPage> createState() => _OrganizerMapPageState();
}

class _OrganizerMapPageState extends State<OrganizerMapPage> {
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
    var state = widget.parentContex.watch<RootCubit>();
    final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

    Future<void> _goToCoordinate() async {
      CameraPosition _newLoc = CameraPosition(target: state.currentLocation!, tilt: 60, zoom: 14);
      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(_newLoc));
    }

    return state.currentLocation!.latitude != 0
        ? BlocListener(
            bloc: BlocProvider.of<RootCubit>(widget.parentContex),
            listener: (context, state) {
              Future.delayed(const Duration(seconds: 2), () {
                _goToCoordinate();
              });
            },
            child: Stack(
              children: [
                //Google Maps Widgets
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(target: widget.parentContex.watch<RootCubit>().currentLocation!, zoom: 14),
                  markers: Set.of(_markerList),
                  indoorViewEnabled: false,
                  mapToolbarEnabled: false,
                  zoomControlsEnabled: true,
                  buildingsEnabled: false,
                  myLocationButtonEnabled: true,
                  tiltGesturesEnabled: false,
                ),
              ],
            ),
          )
        : const LoadingBar();
  }

//Markers
  loadingMarkerData() async {
    Uint8List customMarker;
    await Future.wait(widget.organizerdata.map((organizerElement) async => {
          Future.wait(organizerElement.event!.map((eventItem) async => {
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
                                        image: DecorationImage(image: NetworkImage(eventItem.imageUrl.toString()), fit: BoxFit.cover)),
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

List<CategoryModel> selectedCategory = [];
