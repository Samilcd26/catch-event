import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/services/ISSFLService.dart';
import '../Models/organizer_model.dart';

class SSFLCubit extends Cubit<SSFLState> {
  final ISSFLService ssflService;
  SSFLCubit({required this.ssflService}) : super(SSFLInitial());
  List<CommentModel> commentsList = [];

  void followOrganizer(int userId, int organizerId) {
    ssflService.followOrganizer(userId, organizerId);
  }

  void unfollowOrganizer(int userId, int organizerId) {
    ssflService.unfollowOrganizer(userId, organizerId);
  }

  void addLikeToEvent(int userId, int eventId) {
    ssflService.addLikeToEvent(userId, eventId);
  }

  void unlikeEvent(int userId, int eventId) {
    ssflService.removelikeEvent(userId, eventId);
  }

  void saveOrganizerEventToUserStore(int userId, int eventId) {
    ssflService.saveOrganizerEventToUserStore(userId, eventId);
  }

  void removeOrganizerEventToUserStore(int userId, int eventId) {
    ssflService.removeOrganizerEventToUserStore(userId, eventId);
  }

  void addCommentToEvent(int userId, int eventId, CommentModel comment) {
    ssflService.addCommentToEvent(userId, eventId, comment);
  }

  void removeCommentToEvent(int userId, int eventId, int commentId) {
    ssflService.removeCommentToEvent(userId, eventId, commentId);
  }

  void getCommentList(List<int>? commentIdList) async {
    final data = await ssflService.getCommentList(commentIdList);
    commentsList = data;
  }
}

abstract class SSFLState {}

class SSFLInitial extends SSFLState {}
