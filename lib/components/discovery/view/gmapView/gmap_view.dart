import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:readmore/readmore.dart';

import '../../../../Data/Models/category_model.dart';
import '../../../../Data/Models/organizer_model.dart';
import '../../../../Data/State/account_cubit.dart';
import '../../../../core/product/helper/loading_animation.dart';
import '../../../../core/product/helper/stack.dart';
import '../../../../core/product/navigator/app_router.dart';
import '../listView/list_view.dart';

@RoutePage()
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
  String _mapStyle = "";
  ////////////////////////////////
  @override
  void initState() {
    rootBundle.loadString('assets/mapStyle/dark_map.txt').then((string) {
      _mapStyle = string;
    });
    loadingMarkerData();
    super.initState();
  }

  /////////////////////////////////////////////////////////////////
  /// Main widget /////////////////////////////////////////////////P
  @override
  Widget build(BuildContext context) {
    var state = widget.parentContex.watch<AccountCubit>();
    final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

    Future<void> _goToCoordinate() async {
      CameraPosition _newLoc = CameraPosition(target: state.currentLocation!, tilt: 60, zoom: 14);
      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(_newLoc));
    }

    return state.currentLocation!.latitude != 0
        ? BlocListener(
            bloc: BlocProvider.of<AccountCubit>(widget.parentContex)..changeState,
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
                    controller.setMapStyle(_mapStyle);
                  },
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(target: widget.parentContex.watch<AccountCubit>().currentLocation!, zoom: 14),
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
                              //backgroundColor: const Color.fromARGB(255, 235, 235, 235),
                              context: context,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                              builder: (context) {
                                return Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                                  //Divider
                                  // Bgimage
                                  GradientBackgroundImages(
                                    imageUrl: eventItem.imageUrl.toString(),
                                    children: [
                                      //Cancel Button
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            onPressed: () => Navigator.pop(context),
                                            icon: const Icon(Icons.cancel),
                                          )),
                                      const Spacer(),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(eventItem.title.toString(), style: Theme.of(context).textTheme.headlineSmall)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          IntrinsicHeight(
                                            child: Row(
                                              children: [
                                                InfoIconText(text: eventItem.category!, icon: Icons.local_activity),
                                                VerticalDivider(),
                                                Text("+18"),
                                                VerticalDivider(),
                                                Text(eventItem.price == 0 ? "free" : eventItem.price.toString())
                                              ],
                                            ),
                                          ),
                                          Text("06-04-2001\n22:04", textAlign: TextAlign.center)
                                        ],
                                      )
                                    ],
                                  ),

                                  ListTile(
                                    onTap: () => AutoRouter.of(context).push(EventInfoRoute(event: eventItem)),
                                    title: const Text('Etkinlik Detayı'),
                                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                                    subtitle: ReadMoreText(
                                      eventItem.description.isNullOrEmpty ? "..." : eventItem.description.isNullOrEmpty.toString(),
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
