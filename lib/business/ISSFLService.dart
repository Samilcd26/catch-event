import 'package:http/http.dart' as http;
import 'package:vexana/vexana.dart';

import '../../Data/Models/organizer_model.dart';

abstract class ISSFLService {
  final INetworkManager networkManager;
  ISSFLService(this.networkManager);

  bool isLoading = false;

  //Get Organizer by city name
  Future<http.Response> followOrganizer(int userId, int organizerId);
  Future<http.Response> unfollowOrganizer(int userId, int organizerId);
  //
  Future<http.Response> addLikeToEvent(int userId, int eventId);
  Future<http.Response> removelikeEvent(int userId, int eventId);
//
  Future<http.Response> addDislikeToEvent(int userId, int eventId);
  Future<http.Response> removeDislikeEvent(int userId, int eventId);
//
  Future<http.Response> saveOrganizerEventToUserStore(int userId, int eventId);
  Future<http.Response> removeOrganizerEventToUserStore(int userId, int eventId);
  //
  Future<http.Response> addCommentToEvent(int userId, int eventId, CommentModel comment);
  Future<http.Response> removeCommentToEvent(int userId, int eventId, int commentId);
  Future<List<CommentModel>> getCommentList(List<int>? commentIdList);
}
