import 'package:http/http.dart' as http;
import 'package:vexana/vexana.dart';

import '../../../Data/Models/organizer_model.dart';
import '../../../Data/Models/user_model.dart';
import '../../../core/product/services/network_service.dart';
import '../IAccountService.dart';

class AccountService extends IAccountService {
  AccountService(INetworkManager networkManager) : super(networkManager);

  final String baseUrl = "http://192.168.1.67:8099/api/v1";
  final String apiKey = "AIzaSyAQZ-vxDLx856vCV38MFiWJhUIN_qmeS4k";
  @override
  Future<UserModel?> getUserById(int id) async {
    final response =
        await networkManager.send<UserModel, UserModel>('$baseUrl/user/find?id=$id', parseModel: UserModel(), method: RequestType.GET);

    return response.data;
  }

  @override
  Future<List<OrganizerModel>?> getFollowOrganizers(List<int> idList) async {
    final response = await networkManager.send<OrganizerModel, List<OrganizerModel>>('$baseUrl/user/getFollowers',
        options: Options(headers: NetworkService.getHeader()), parseModel: OrganizerModel(), method: RequestType.GET, data: idList);
    //print(networkManager.allHeaders);
    return response.data;
  }

  @override
  Future<bool> toBeOrganizer(int userId) async {
    late http.Response respons;
    await http
        .get(Uri.parse('$baseUrl/user/toBeOrganizer?userId=$userId'), headers: NetworkService.getHeader())
        .then((value) => respons = value);

    return respons.statusCode == 200 ? true : false;
  }

  @override
  Future<OrganizerModel?> getCurretnOrganizer(int organizerId) async {
    final response = await networkManager.send<OrganizerModel, OrganizerModel>('$baseUrl/organizer/getDataById?organizerId=$organizerId',
        parseModel: OrganizerModel(), method: RequestType.GET);

    return response.data;
  }

  @override
  Future<UserModel?> loginUser(String email, String password) async {
    final response = await networkManager.send<UserModel, UserModel>('$baseUrl/auth/authenticate',
        parseModel: UserModel(),
        method: RequestType.POST,
        options: Options(),
        isErrorDialog: true,
        data: {"email": email, "password": password});
    if (response.error == null) {
      NetworkService.setHeader(response.data!.accessToken!);
      chechApiToken();
      return response.data;
    }
  }

  Future<void> chechApiToken() async {
    if (networkManager.allHeaders["Accept"] == null) {
      NetworkService.globalHeader.forEach((key, value) {
        networkManager.addBaseHeader(MapEntry(key, value));
      });
    }
  }
}


/*var respons;
    await http
        .post(Uri.parse('$baseUrl/auth/authenticate'),
            headers: {"Content-type": "application/json"}, body: jsonEncode(<String, String>{'email': email, 'password': password}))
        .then((value) => respons = value);
     */