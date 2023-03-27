import 'package:geolocator/geolocator.dart';
import 'package:vexana/vexana.dart';

import '../../Data/Models/distance_model.dart';
import '../../Data/Models/publisher_model.dart';

abstract class IPublisherService {
  final INetworkManager networkManager;
  IPublisherService(this.networkManager);

  bool isLoading = false;

  //Get Publisher by city name
  Future<List<PublisherModel>?> getPubliscerByCity(String city);
  Future<List<PublisherModel>?> searchPublisher(String publisherName);
  Future<Position> getCurrentLocation();
  Future<DistanceModel?> getDistance(double dlat, double dlot, double clat, double clot);
}
