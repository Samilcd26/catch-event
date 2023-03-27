import 'package:vexana/vexana.dart';

class NetworkService {
  static NetworkService? _instace;
  static NetworkService get instance {
    _instace ??= NetworkService._init();
    return _instace!;
  }

  late final INetworkManager networkManager;

  NetworkService._init() {
    networkManager = NetworkManager<EmptyModel>(isEnableLogger: true, options: BaseOptions(baseUrl: ''));
  }
}
