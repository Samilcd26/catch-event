// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:threego/business/impl/LocationService.dart';
import 'package:threego/core/network/network_service.dart';

import '../../../Data/Models/gaddress_model.dart';
import '../../../Data/Models/organizer_model.dart';
import '../../../Data/State/account_cubit.dart';
import '../../../Data/State/organizer_cubit.dart';

@RoutePage()
class SearchLocationPage extends StatefulWidget {
  SearchLocationPage({super.key, required this.isChangeCurrentLocation});
  late bool isChangeCurrentLocation;
  @override
  State<SearchLocationPage> createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late final LocationService _localService;
  final locationAddress = TextEditingController();
  String _mapStyle = "";

  List<Marker> currentMarker = [];
  LatLng selectedCoordinate = LatLng(0, 0);
  String addressText = "";
  Address selectedAddress = Address();
  @override
  void initState() {
    rootBundle.loadString('assets/mapStyle/dark_map.txt').then((string) {
      _mapStyle = string;
    });
    super.initState();
    _localService = LocationService(NetworkService.getInstance(context).networkManager);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 90),
          child: FloatingActionButton(
              child: const Icon(Icons.save),
              onPressed: () async {
                //!!!!!!!!!!!!!!!!!!!!!!Burayı yeniden düzenle
                Results? _data = await _localService.getLocationByCoordinate(selectedCoordinate);

                var _addressComponent = _data!.addressComponents;
                _addressComponent!.forEach((element) {
                  if (element.types!.contains("country")) {
                    //!County
                    selectedAddress.country = element.longName;
                  } else if (element.types!.contains("postal_code")) {
                    //!Postal Code
                    selectedAddress.postalCode = element.longName;
                  } else if (element.types!.contains("administrative_area_level_1")) {
                    //!City
                    selectedAddress.city = element.longName;
                  } else if (element.types!.contains("administrative_area_level_2")) {
                    //!District
                    selectedAddress.district = element.longName;
                  } else if (element.types!.contains("administrative_area_level_4")) {
                    //!District
                    selectedAddress.address1 = element.longName;
                  } else if (element.types!.contains("route")) {
                    //!District
                    selectedAddress.address2 = element.longName;
                  }
                });

                selectedAddress.address1 = _data.formattedAddress;
                selectedAddress.coordinate = Coordinate(latitude: _data.geometry!.location!.lat, longitude: _data.geometry!.location!.lat);

                if (!widget.isChangeCurrentLocation) {
                  context.read<OrganizerCubit>().setNewEventAddress(selectedAddress);
                  //Event başlatılınca setNewEventAddress temizle
                } else {
                  context.read<AccountCubit>().changeCurrentLocation(
                      LatLng(selectedAddress.coordinate!.latitude!, selectedAddress.coordinate!.longitude!), selectedAddress);
                }
                AutoRouter.of(context).back();
              }),
        ),
        body: Stack(
          children: [
            GoogleMap(
              onTap: (argument) {
                setState(() {
                  selectedCoordinate = argument;
                  currentMarker.add(Marker(markerId: MarkerId("-10"), icon: BitmapDescriptor.defaultMarker, position: selectedCoordinate));
                });
              },
              myLocationEnabled: true,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              markers: Set.of(currentMarker),
              initialCameraPosition: CameraPosition(target: context.read<AccountCubit>().currentLocation ?? LatLng(0, 0)),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                controller.setMapStyle(_mapStyle);
              },
            ),
            Row(
              children: [
                IconButton(onPressed: () => AutoRouter.of(context).back(), icon: const Icon(Icons.arrow_back_ios_new)),
                Expanded(
                  child: TextField(
                    controller: locationAddress,
                    decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: IconButton(
                              onPressed: () {
                                _goToCoordinate();
                              },
                              icon: const Icon(Icons.search)),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _goToCoordinate() async {
    var address = locationAddress.text.replaceAll(" ", "+");
    Results? _coordinate = await _localService.getLocationByAddress(address);
    LatLng _latLng;
    CameraPosition _newLoc =
        CameraPosition(target: LatLng(_coordinate!.geometry!.location!.lat!, _coordinate.geometry!.location!.lng!), tilt: 60, zoom: 14);
    final GoogleMapController controller = await _controller.future;
    _latLng = LatLng(_coordinate.geometry!.location!.lat!, _coordinate.geometry!.location!.lng!);
    setState(() {
      selectedCoordinate = _latLng;
      addressText = _coordinate.addressComponents!.first.longName!;
    });

    controller.animateCamera(CameraUpdate.newCameraPosition(_newLoc));
  }
}
