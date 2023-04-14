import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';

import '../../business/services/IAccountService.dart';
import '../../business/services/IOrganizerService.dart';
import '../Models/filter_organizer_model.dart';
import '../Models/organizer_model.dart';
import '../Models/user_model.dart';

class RootCubit extends Cubit<RootState> {
  final IOrganizerService organizerService;
  final IAccountService accoundService;
  //
  List<OrganizerModel> organizerData = [];
  List<Event>? events = [];
  LatLng? currentLocation;
  Address? currentAddress;
  bool isLoading = false;
  final int userId = 1;
  UserModel? currentUser = UserModel();
  List<OrganizerModel>? followOrganizerList = [];
  FilterOrganizerModel filterModel =
      FilterOrganizerModel("Türkiye", "Eskişehir", 1, null, null, null, null, null, null, null, null, null, null, null, null);
//
  RootCubit({required this.organizerService, required this.accoundService}) : super(RootInitial());

  List<OrganizerModel>? searchList = [];

  Future<void> getAllOrganizerByFilter() async {
    final data = await organizerService.getOrganizerByFilter(filterModel);
    organizerData = data!;
    emit(SuccesOrganizerData(data));
  }

  Future<void> _getAllEvent() async {
    events!.clear();
    Future.wait(organizerData.expand((org) => org.event!.map((ev) async => events!.add(ev))));

    emit(AddEventList(events!));
  }

  void _changeLoadingStatus() {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }

  Future<void> changeCurrentLocation(LatLng newLocation, Address newAddres) async {
    currentLocation = newLocation;
    currentAddress = newAddres;
    filterModel.country = newAddres.country;
    filterModel.city = newAddres.city;
    emit(ChangeCurrentLocation(newLocation));
    loadingInitData();
  }

  Future<void> _getUserById() async {
    final data = await accoundService.getUserById(userId);
    currentUser = data;
    // emit(SuccesOrganizerData(data));
  }

  Future<void> _getCurrentLocation() async {
    final data;
    if (currentLocation == null) {
      data = await organizerService.getCurrentLocation();

      currentLocation = LatLng(data.latitude, data.longitude);
    }
  }

  Future<void> _getFollowOrganizers() async {
    if (currentUser!.followOrganizer.isNotNullOrEmpty) {
      final data = await accoundService.getFollowOrganizers(currentUser!.followOrganizer!);
      followOrganizerList = [];
      followOrganizerList = data;
    }
  }

  Future<void> searchOrganizer(String organizerName) async {
    final data = await organizerService.searchOrganizer(organizerName);
    searchList = [];
    searchList = data!;
  }

  Future<void> loadingInitData() async {
    await _getUserById();
    await _getCurrentLocation();
    await getAllOrganizerByFilter();
    await _getFollowOrganizers();
    await _getAllEvent();
    isLoading ? "" : _changeLoadingStatus();
    //emit(LoginLoadingState(isLoading));
  }

/*
   Future<void> searchLocationAddress(String address) async {
    final data = await organizerService.searchOrganizer(organizerName);
    searchList = data!;
  }

  */
}

abstract class RootState {}

class RootInitial extends RootState {}

class SuccesOrganizerData extends RootState {
  final List<OrganizerModel> model;

  SuccesOrganizerData(this.model);
}

class AddEventList extends RootState {
  final List<Event> model;

  AddEventList(this.model);
}

class SuccesCurrentPosition extends RootState {
  final Position? data;

  SuccesCurrentPosition(this.data);
}

class LoginLoadingState extends RootState {
  bool isLoading;

  LoginLoadingState(this.isLoading);
}

class ChangeCurrentLocation extends RootState {
  final LatLng newLocation;

  ChangeCurrentLocation(this.newLocation);
}
