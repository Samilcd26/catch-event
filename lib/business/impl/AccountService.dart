import 'package:http/http.dart' as http;
import 'package:threego/core/network/network_service.dart';
import 'package:vexana/vexana.dart';

import '../../../Data/Models/organizer_model.dart';
import '../../../Data/Models/user_model.dart';
import '../IAccountService.dart';

import '../../../globals.dart' as globals;

class AccountService extends IAccountService {
  AccountService(INetworkManager networkManager) : super(networkManager);

  //? BackEnd API Address
  final String baseUrl = globals.apiUrl;
  //? Google API Key
  final String apiKey = globals.apiKey;

  //? /////////////////////////////////////////////////////////////////////////
  //? /////////////////////////////////////////////////////////////////////////
  @override
  Future<UserModel?> getUserById(int id) async {
    final response =
        await networkManager.send<UserModel, UserModel>('$baseUrl/user/find?id=$id', parseModel: UserModel(), method: RequestType.GET);

    return response.data;
  }
  //? /////////////////////////////////////////////////////////////////////////

  @override
  Future<List<OrganizerModel>?> getFollowOrganizers(List<int> idList) async {
    final response = await networkManager.send<OrganizerModel, List<OrganizerModel>>('$baseUrl/user/getFollowers',
        options: Options(headers: NetworkService.getHeader()), parseModel: OrganizerModel(), method: RequestType.GET, data: idList);
    //print(networkManager.allHeaders);
    return response.data;
  }

  //? /////////////////////////////////////////////////////////////////////////
  @override
  Future<bool> toBeOrganizer(int userId) async {
    late http.Response respons;
    await http
        .get(Uri.parse('$baseUrl/user/toBeOrganizer?userId=$userId'), headers: NetworkService.getHeader())
        .then((value) => respons = value);

    return respons.statusCode == 200 ? true : false;
  }

  //? /////////////////////////////////////////////////////////////////////////
  @override
  Future<OrganizerModel?> getCurrentOrganizer(int organizerId) async {
    final response = await networkManager.send<OrganizerModel, OrganizerModel>('$baseUrl/organizer/getDataById?organizerId=$organizerId',
        parseModel: OrganizerModel(), method: RequestType.GET);

    return response.data;
  }

  //? /////////////////////////////////////////////////////////////////////////
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
    return null;
  }

  //? /////////////////////////////////////////////////////////////////////////
  Future<void> chechApiToken() async {
    if (networkManager.allHeaders["Accept"] == null) {
      NetworkService.globalHeader.forEach((key, value) {
        networkManager.addBaseHeader(MapEntry(key, value));
      });
    }
  }

  //? /////////////////////////////////////////////////////////////////////////
  @override
  Future<bool> register(RegisterModel register) async {
    final response = await networkManager.send<RegisterModel, RegisterModel>('$baseUrl/auth/register',
        parseModel: RegisterModel(),
        method: RequestType.POST,
        options: Options(),
        isErrorDialog: true,
        data: {"firstname": register.firstname, "password": register.password, "lastname": register.lastname, "email": register.email});
    return response.error == null ? true : false;
  }
  //? /////////////////////////////////////////////////////////////////////////
}
