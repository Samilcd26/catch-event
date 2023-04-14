import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vexana/vexana.dart';

import '../../Data/Models/gaddress_model.dart';

abstract class ILocationService {
  final INetworkManager networkManager;
  ILocationService(this.networkManager);
  bool isLoading = false;

  //Get Organizer by city name

  Future<Results?> getLocationByAddress(String address);
  Future<Results?> getLocationByCoordinate(LatLng address);
}
