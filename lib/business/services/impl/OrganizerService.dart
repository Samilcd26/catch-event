import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:vexana/vexana.dart';

import '../../../Data/Models/distance_model.dart';
import '../../../Data/Models/filter_organizer_model.dart';
import '../../../Data/Models/organizer_model.dart';
import '../../../core/product/services/network_service.dart';
import '../IOrganizerService.dart';

class OrganizerService extends IOrganizerService {
  OrganizerService(INetworkManager networkManager) : super(networkManager);
  final String baseUrl = "http://192.168.1.67:8099/api/v1";
  final String apiKey = "AIzaSyAQZ-vxDLx856vCV38MFiWJhUIN_qmeS4k";

  @override
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<DistanceModel?> getDistance(double dlat, double dlot, double clat, double clot) async {
    final response = await networkManager.send<DistanceModel, DistanceModel>(
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$dlat,$dlot&origins=$clat,$clot&key=$apiKey',
        parseModel: DistanceModel(),
        method: RequestType.GET);

    return response.data;
  }

  @override
  Future<List<OrganizerModel>?> getOrganizerByFilter(FilterOrganizerModel filter) async {
    final response = await http.post(Uri.parse('$baseUrl/organizer/allDataByFilter'),
        headers: NetworkService.globalHeader, body: jsonEncode(filter.toJson()));

    if (response.statusCode == 200) {
      List<OrganizerModel> organizerList = [];
      List jsonResponse = json.decode(response.body);

      await Future.wait(jsonResponse.map((e) async => organizerList.add(OrganizerModel.fromJson(e))));

      return organizerList;
    }
  }

  @override
  Future<List<OrganizerModel>?> searchOrganizer(String organizerName) async {
    final response = await networkManager.send<OrganizerModel, List<OrganizerModel>>(
        '$baseUrl/organizer/search?organizerName=$organizerName',
        parseModel: OrganizerModel(),
        method: RequestType.GET);

    return response.data;
  }

  @override
  Future<OrganizerModel?> getOrganizerById(int organizerId) async {
    final response = await networkManager.send<OrganizerModel, OrganizerModel>('$baseUrl/organizer/getDataById?organizerId=$organizerId',
        parseModel: OrganizerModel(), method: RequestType.GET);

    return response.data;
  }

  @override
  Future<bool> createNewEvent(int organizerId, Event eventModel) async {
    inspect(NetworkService.getHeader());
    final response = await http.post(Uri.parse('$baseUrl/organizer/addEvent?organizerId=$organizerId'),
        headers: NetworkService.getHeader(), body: jsonEncode(eventModel.toJson()));
    return response.statusCode == 200 ? true : false;
  }
}
