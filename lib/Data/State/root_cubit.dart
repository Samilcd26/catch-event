import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../business/services/IAccountService.dart';
import '../../business/services/IOrganizerService.dart';
import '../Models/organizer_model.dart';
import '../Models/user_model.dart';

class RootCubit extends Cubit<RootState> {
  final IOrganizerService organizerService;
  final IAccountService accoundService;
  //
  List<OrganizerModel> organizerData = [];
  List<Event>? events = [];
  LatLng? cordinate;
  bool isLoading = false;
  final int userId = 1;
  UserModel? currentUser = UserModel();
  List<OrganizerModel>? followOrganizerList = [];
//
  RootCubit({required this.organizerService, required this.accoundService}) : super(RootInitial());

  List<OrganizerModel>? searchList = [];

  Future<void> _getAllOrganizerByCity() async {
    final data = await organizerService.getOrganizerByCity("Eskişehir", "Türkiye", currentUser!.id!);

    organizerData = data!;
    // emit(SuccesOrganizerData(data));
  }

  Future<void> _getAllEvent() async {
    events!.clear();
    Future.wait(organizerData.expand((org) => org.event!.map((ev) async => events!.add(ev))));

    inspect(events);
  }

  void _changeLoadingStatus() {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }

  Future<void> _getUserById() async {
    final data = await accoundService.getUserById(userId);
    currentUser = data;
    // emit(SuccesOrganizerData(data));
  }

  Future<void> _getCurrentLocation() async {
    final data = await organizerService.getCurrentLocation();

    cordinate = LatLng(data.latitude, data.longitude);
    //emit(SuccesCurrentPosition(data));
  }

  Future<void> _getFollowOrganizers() async {
    if (currentUser!.followOrganizer != null) {
      final data = await accoundService.getFollowOrganizers(currentUser!.followOrganizer!);
      followOrganizerList = data;
    }
  }

  Future<void> searchOrganizer(String organizerName) async {
    final data = await organizerService.searchOrganizer(organizerName);
    searchList = data!;
  }

  Future<void> loadingInitData() async {
    await _getUserById();
    await _getCurrentLocation();
    await _getAllOrganizerByCity();
    await _getFollowOrganizers();
    await _getAllEvent();
    isLoading ? "" : _changeLoadingStatus();
  }
}

abstract class RootState {}

class RootInitial extends RootState {}

class SuccesOrganizerData extends RootState {
  final List<OrganizerModel> model;

  SuccesOrganizerData(this.model);
}

class SuccesCurrentPosition extends RootState {
  final Position? data;

  SuccesCurrentPosition(this.data);
}

class LoginLoadingState extends RootState {
  bool isLoading;

  LoginLoadingState(this.isLoading);
}
