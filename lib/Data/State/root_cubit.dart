import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../business/services/IAccountService.dart';
import '../../business/services/IPublisherService.dart';
import '../Models/publisher_model.dart';
import '../Models/user_model.dart';

class RootCubit extends Cubit<RootState> {
  final IPublisherService publisherService;
  final IAccountService accoundService;
  //
  List<PublisherModel> publisherData = [];
  LatLng? cordinate;
  bool isLoading = false;
  final String userId = "fcb62289-88bb-4f77-9f15-0d96a15824d3";
  UserModel? currentUser = UserModel();
  List<PublisherModel>? followPublisherList = [];
//
  RootCubit({required this.publisherService, required this.accoundService}) : super(RootInitial());

  List<PublisherModel>? searchList = [];

  Future<void> _getAllPublisherByCity() async {
    final data = await publisherService.getPubliscerByCity("Eskişehir");

    publisherData = data!;
    // emit(SuccesPublisherData(data));
  }

  void _changeLoadingStatus() {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }

  Future<void> _getUserById() async {
    final data = await accoundService.getUserById(userId);
    currentUser = data;
    // emit(SuccesPublisherData(data));
  }

  Future<void> _getCurrentLocation() async {
    final data = await publisherService.getCurrentLocation();

    cordinate = LatLng(data.latitude, data.longitude);
    //emit(SuccesCurrentPosition(data));
  }

  Future<void> _getFollowPublishers() async {
    final data = await accoundService.getFollowPublishers(currentUser!.flowPublisher!);
    followPublisherList = data;
  }

  Future<void> searchPublisher(String publisherName) async {
    final data = await publisherService.searchPublisher(publisherName);
    searchList = data!;
  }

  Future<void> loadingInitData() async {
    await _getUserById();
    await _getCurrentLocation();
    await _getAllPublisherByCity();
    await _getFollowPublishers();
    isLoading ? "" : _changeLoadingStatus();
  }
}

abstract class RootState {}

class RootInitial extends RootState {}

class SuccesPublisherData extends RootState {
  final List<PublisherModel> model;

  SuccesPublisherData(this.model);
}

class SuccesCurrentPosition extends RootState {
  final Position? data;

  SuccesCurrentPosition(this.data);
}

class LoginLoadingState extends RootState {
  bool isLoading;

  LoginLoadingState(this.isLoading);
}
