import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../business/services/IOrganizerService.dart';
import '../Models/organizer_model.dart';

class OrganizerCubit extends Cubit<OrganizerState> {
  final IOrganizerService organizerService;
  OrganizerModel? currentOrganizer = OrganizerModel();

  LatLng newEventCoordinate = LatLng(0, 0);
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

  void createNewEvent(Event eventModel) {
    eventModel.address == null ? eventModel.address = [eventAddress] : eventModel.address!.add(eventAddress);

    organizerService.createNewEvent(currentOrganizer!.id!, eventModel);
  }
}

abstract class OrganizerState {}

class OrganizerInitial extends OrganizerState {}
