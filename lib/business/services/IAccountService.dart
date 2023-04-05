import 'package:vexana/vexana.dart';

import '../../Data/Models/organizer_model.dart';
import '../../Data/Models/user_model.dart';

abstract class IAccountService {
  final INetworkManager networkManager;
  IAccountService(this.networkManager);

  bool isLoading = false;

  //Get Organizer by city name
  Future<UserModel?> getUserById(int id);
  Future<List<OrganizerModel>?> getFollowOrganizers(List<int> idList);
}
