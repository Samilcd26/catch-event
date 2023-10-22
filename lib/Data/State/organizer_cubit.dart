import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:threego/business/IOrganizerService.dart';

import '../Models/organizer_model.dart';

class OrganizerCubit extends Cubit<OrganizerState> {
  final IOrganizerService organizerService;
  OrganizerModel? currentOrganizer = OrganizerModel();
  List<OrganizerModel>? searchList = [];
  LatLng newEventCoordinate = const LatLng(0, 0);
  String newEventAddres = "";
  Address eventAddress = Address();
  OrganizerCubit({required this.organizerService}) : super(OrganizerInitial());

  Future<void> getOrganizerById(int organizerId) async {
    final data = await organizerService.getOrganizerById(organizerId);

    currentOrganizer = data!;
    // emit(SuccesOrganizerData(data));
  }

  void setNewEventAddress(Address newAddress) async {
    eventAddress = newAddress;
  }

  Future<bool> createNewEvent(Event eventModel) async {
    eventModel.address == null ? eventModel.address = [eventAddress] : eventModel.address!.add(eventAddress);

    return await organizerService.createNewEvent(currentOrganizer!.id!, eventModel);
  }

  Future<void> searchOrganizer(String organizerName) async {
    final data = await organizerService.searchOrganizer(organizerName);
    searchList = [];
    searchList = data!;
  }
}

abstract class OrganizerState {}

class OrganizerInitial extends OrganizerState {}
