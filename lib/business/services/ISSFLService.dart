import 'package:vexana/vexana.dart';

import '../../Data/Models/organizer_model.dart';

abstract class ISSFLService {
  final INetworkManager networkManager;
  ISSFLService(this.networkManager);

  bool isLoading = false;

  //Get Organizer by city name
  Future<void> followOrganizer(int userId, int organizerId);
  Future<void> unfollowOrganizer(int userId, int organizerId);
  //
  Future<void> addLikeToEvent(int userId, int eventId);
  Future<void> removelikeEvent(int userId, int eventId);
//
  Future<void> saveOrganizerEventToUserStore(int userId, int eventId);
  Future<void> removeOrganizerEventToUserStore(int userId, int eventId);
  //
  Future<void> addCommentToEvent(int userId, int eventId, CommentModel comment);
  Future<void> removeCommentToEvent(int userId, int eventId, int commentId);
  Future<List<CommentModel>> getCommentList(List<int>? commentIdList);
}
