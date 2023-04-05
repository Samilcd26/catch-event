import 'package:geolocator/geolocator.dart';
import 'package:vexana/vexana.dart';

import '../../Data/Models/distance_model.dart';
import '../../Data/Models/organizer_model.dart';

abstract class IOrganizerService {
  final INetworkManager networkManager;
  IOrganizerService(this.networkManager);

  bool isLoading = false;

  //Get Organizer by city name
  Future<List<OrganizerModel>?> getOrganizerByCity(String city, String country, int userId);
  Future<OrganizerModel?> getOrganizerById(int organizerId);
  Future<List<OrganizerModel>?> searchOrganizer(String organizerName);
  Future<Position> getCurrentLocation();
  Future<DistanceModel?> getDistance(double dlat, double dlot, double clat, double clot);
}
