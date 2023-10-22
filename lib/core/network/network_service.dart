import 'package:flutter/material.dart';
import 'package:vexana/vexana.dart';

class NetworkService {
  static NetworkService? _instace;

  static Map<String, String> globalHeader = {'Content-type': 'application/json'};
  static NetworkService getInstance(BuildContext context) {
    _instace ??= NetworkService._init({'Content-type': 'application/json'}, context);
    return _instace!;
  }

  /*
  static NetworkService get instance (){
    _instace ??= NetworkService._init({'Content-type': 'application/json'});
    return _instace!;
  }
*/
  static void setHeader(String token) {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    globalHeader = requestHeaders;
    //NetworkService._init(requestHeaders);
  }

  static Map<String, String> getHeader() {
    return globalHeader;
  }

  late final INetworkManager networkManager;

  NetworkService._init(Map<String, String> requestHeaders, BuildContext context) {
    networkManager = NetworkManager<EmptyModel>(
        isEnableLogger: true,
        noNetwork: NoNetwork(
          context,
        ),
        options: BaseOptions(
          baseUrl: '',
          headers: requestHeaders,
        ));
  }
}
