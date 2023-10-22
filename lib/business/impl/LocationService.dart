import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:threego/core/network/network_service.dart';
import 'package:vexana/vexana.dart';

import '../../../Data/Models/gaddress_model.dart';

import '../ILocationService.dart';
import '../../../globals.dart' as globals;

class LocationService extends ILocationService {
  LocationService(INetworkManager networkManager) : super(networkManager);
  final String googleKey = globals.apiKey;

  @override
  Future<Results?> getLocationByAddress(String address) async {
    final response = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$googleKey'),
        headers: NetworkService.getHeader());
    if (response.statusCode == 200) {
      var deger = GAddressModel.fromJson(jsonDecode(response.body));
      return deger.results!.first;
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Future<Results?> getLocationByCoordinate(LatLng coordinate) async {
    final response = await http.get(
        Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=${coordinate.latitude},${coordinate.longitude}&key=$googleKey'),
        headers: NetworkService.getHeader());
    if (response.statusCode == 200) {
      var deger = GAddressModel.fromJson(jsonDecode(response.body));
      return deger.results![0];
    } else {
      throw Exception('Failed to load album');
    }
  }
}
