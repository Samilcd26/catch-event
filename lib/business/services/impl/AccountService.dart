import 'package:vexana/vexana.dart';

import '../../../Data/Models/publisher_model.dart';
import '../../../Data/Models/user_model.dart';
import '../IAccountService.dart';

class AccountService extends IAccountService {
  AccountService(INetworkManager networkManager) : super(networkManager);

  final String baseUrl = "http://192.168.1.105:8099/api/v1";

  @override
  Future<UserModel?> getUserById(String id) async {
    final response =
        await networkManager.send<UserModel, UserModel>('$baseUrl/user/find?id=$id', parseModel: UserModel(), method: RequestType.GET);

    return response.data;
  }

  @override
  Future<List<PublisherModel>?> getFollowPublishers(List<String> idList) async {
    final response = await networkManager.send<PublisherModel, List<PublisherModel>>('$baseUrl/user/follows',
        parseModel: PublisherModel(), method: RequestType.POST, data: idList);

    return response.data;
  }
}
