import 'package:vexana/vexana.dart';

import '../../../Data/Models/organizer_model.dart';
import '../../../Data/Models/user_model.dart';
import '../IAccountService.dart';

class AccountService extends IAccountService {
  AccountService(INetworkManager networkManager) : super(networkManager);

  final String baseUrl = "http://192.168.1.105:8099/api/v1";

  @override
  Future<UserModel?> getUserById(int id) async {
    final response =
        await networkManager.send<UserModel, UserModel>('$baseUrl/user/find?id=$id', parseModel: UserModel(), method: RequestType.GET);

    return response.data;
  }

  @override
  Future<List<OrganizerModel>?> getFollowOrganizers(List<int> idList) async {
    final response = await networkManager.send<OrganizerModel, List<OrganizerModel>>('$baseUrl/user/getFollowers',
        parseModel: OrganizerModel(), method: RequestType.GET, data: idList);

    return response.data;
  }
}
