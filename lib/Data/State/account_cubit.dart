import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/services/IAccountService.dart';
import '../Models/organizer_model.dart';
import '../Models/user_model.dart';

class AccountCubit extends Cubit<AccountState> {
  final IAccountService accoundService;
  AccountCubit({required this.accoundService}) : super(AccountInitial());
  bool isLoading = false;
  int userId = 1;
  UserModel? currentUser = UserModel();
  OrganizerModel? currentOrganizer = OrganizerModel();
  Future<void> _getUserById() async {
    final data = await accoundService.getUserById(userId);
    currentUser = data;
    // emit(SuccesOrganizerData(data));
  }

  Future<void> _getCurrentOrganizerById() async {
    if (currentUser!.organizer == true) {
      final data = await accoundService.getCurretnOrganizer(currentUser!.byOrganized!.id!);
      currentOrganizer = data;
    }

    // emit(SuccesOrganizerData(data));
  }

  Future<void> loadingUserData() async {
    await _getUserById();
    await _getCurrentOrganizerById();
    isLoading ? "" : _changeLoadingStatus();
  }

  void _changeLoadingStatus() {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }

  void toBeOrganizer(int userId) async {
    await accoundService.toBeOrganizer(userId);
  }
}

abstract class AccountState {}

class AccountInitial extends AccountState {}

class LoginLoadingState extends AccountState {
  bool isLoading;

  LoginLoadingState(this.isLoading);
}
