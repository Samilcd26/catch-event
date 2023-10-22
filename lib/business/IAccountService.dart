import 'package:vexana/vexana.dart';

import '../../Data/Models/organizer_model.dart';
import '../../Data/Models/user_model.dart';

abstract class IAccountService {
  final INetworkManager networkManager;

  IAccountService(this.networkManager);

  bool isLoading = false;

  //Get Organizer by city name
  Future<UserModel?> loginUser(String email, String password);
  Future<UserModel?> getUserById(int id);
  Future<OrganizerModel?> getCurrentOrganizer(int organizerId);
  Future<List<OrganizerModel>?> getFollowOrganizers(List<int> idList);
  Future<bool> toBeOrganizer(int userId);
  Future<bool> register(RegisterModel register);
}
