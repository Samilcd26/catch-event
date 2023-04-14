import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:vexana/vexana.dart';

import '../../../Data/Models/gaddress_model.dart';
import '../ILocationService.dart';

class LocationService extends ILocationService {
  LocationService(INetworkManager networkManager) : super(networkManager);
  final String googleKey = "AIzaSyAQZ-vxDLx856vCV38MFiWJhUIN_qmeS4k";

  @override
  Future<Results?> getLocationByAddress(String address) async {
    final String baseUrl = 'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$googleKey';
    final response = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$googleKey'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var deger = GAddressModel.fromJson(jsonDecode(response.body));
      return deger.results!.first;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Future<Results?> getLocationByCoordinate(LatLng coordinate) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${coordinate.latitude},${coordinate.longitude}&key=$googleKey'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var deger = GAddressModel.fromJson(jsonDecode(response.body));
      return deger.results![0];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
