import 'package:geolocator/geolocator.dart';
import 'package:vexana/vexana.dart';

import '../../../Data/Models/distance_model.dart';
import '../../../Data/Models/publisher_model.dart';
import '../IPublisherService.dart';

class PublisherService extends IPublisherService {
  PublisherService(INetworkManager networkManager) : super(networkManager);
  final String baseUrl = "http://192.168.1.105:8099/api/v1";
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
  Future<List<PublisherModel>?> getPubliscerByCity(String city) async {
    final response = await networkManager.send<PublisherModel, List<PublisherModel>>('$baseUrl/publisher/all?city=$city',
        parseModel: PublisherModel(), method: RequestType.GET);

    return response.data;
  }

  @override
  Future<List<PublisherModel>?> searchPublisher(String publisherName) async {
    final response = await networkManager.send<PublisherModel, List<PublisherModel>>(
        '$baseUrl/publisher/search?publisherName=$publisherName',
        parseModel: PublisherModel(),
        method: RequestType.GET);

    return response.data;
  }
}
