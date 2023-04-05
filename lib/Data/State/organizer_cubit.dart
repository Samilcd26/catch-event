import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threego/Data/Models/organizer_model.dart';
import 'package:threego/business/services/IOrganizerService.dart';

class OrganizerCubit extends Cubit<OrganizerState> {
  final IOrganizerService organizerService;
  OrganizerModel currentOrganizer = OrganizerModel();
  OrganizerCubit({required this.organizerService}) : super(OrganizerInitial());

  Future<void> getOrganizerById(int organizerId) async {
    final data = await organizerService.getOrganizerById(organizerId);

    currentOrganizer = data!;
    // emit(SuccesOrganizerData(data));
  }
}

abstract class OrganizerState {}

class OrganizerInitial extends OrganizerState {}
