import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threego/business/ISSFLService.dart';

import '../Models/organizer_model.dart';

class SSFLCubit extends Cubit<SSFLState> {
  final ISSFLService ssflService;
  SSFLCubit({required this.ssflService}) : super(SSFLInitial());
  List<CommentModel> commentsList = [];

  Future<bool> followOrganizer(int userId, int organizerId) async {
    var res = await ssflService.followOrganizer(userId, organizerId);
    return res.statusCode == 200 ? true : false;
  }

  Future<bool> unfollowOrganizer(int userId, int organizerId) async {
    var res = await ssflService.unfollowOrganizer(userId, organizerId);
    return res.statusCode == 200 ? true : false;
  }

  Future<bool> addLikeToEvent(int userId, int eventId) async {
    var res = await ssflService.addLikeToEvent(userId, eventId);
    return res.statusCode == 200 ? true : false;
  }

  Future<bool> removeLikeEvent(int userId, int eventId) async {
    var res = await ssflService.removelikeEvent(userId, eventId);
    return res.statusCode == 200 ? true : false;
  }

  Future<bool> addDislikeToEvent(int userId, int eventId) async {
    var res = await ssflService.addDislikeToEvent(userId, eventId);
    return res.statusCode == 200 ? true : false;
  }

  Future<bool> removeDislikeEvent(int userId, int eventId) async {
    var res = await ssflService.removeDislikeEvent(userId, eventId);
    return res.statusCode == 200 ? true : false;
  }

  Future<bool> saveOrganizerEventToUserStore(int userId, int eventId) async {
    var res = await ssflService.saveOrganizerEventToUserStore(userId, eventId);
    return res.statusCode == 200 ? true : false;
  }

  Future<bool> removeOrganizerEventToUserStore(int userId, int eventId) async {
    var res = await ssflService.removeOrganizerEventToUserStore(userId, eventId);
    return res.statusCode == 200 ? true : false;
  }

  Future<bool> addCommentToEvent(int userId, int eventId, CommentModel comment) async {
    var res = await ssflService.addCommentToEvent(userId, eventId, comment);
    return res.statusCode == 200 ? true : false;
  }

  Future<bool> removeCommentToEvent(int userId, int eventId, int commentId) async {
    var res = await ssflService.removeCommentToEvent(userId, eventId, commentId);
    return res.statusCode == 200 ? true : false;
  }

  Future<void> getCommentList(List<int>? commentIdList) async {
    final data = await ssflService.getCommentList(commentIdList);
    commentsList = data;
  }
}

abstract class SSFLState {}

class SSFLInitial extends SSFLState {}
