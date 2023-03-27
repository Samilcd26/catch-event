import 'package:vexana/vexana.dart';

import '../../Data/Models/publisher_model.dart';
import '../../Data/Models/user_model.dart';

abstract class IAccountService {
  final INetworkManager networkManager;
  IAccountService(this.networkManager);

  bool isLoading = false;

  //Get Publisher by city name
  Future<UserModel?> getUserById(String id);
  Future<List<PublisherModel>?> getFollowPublishers(List<String> idList);
}
