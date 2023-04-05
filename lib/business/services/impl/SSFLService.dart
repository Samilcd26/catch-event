import 'package:http/http.dart' as http;
import 'package:vexana/vexana.dart';

import '../../../Data/Models/organizer_model.dart';
import '../ISSFLService.dart';

class SSFLService extends ISSFLService {
  SSFLService(INetworkManager networkManager) : super(networkManager);

  final String baseUrl = "http://192.168.1.105:8099/api/v1";
  final String apiKey = "AIzaSyAQZ-vxDLx856vCV38MFiWJhUIN_qmeS4k";

  @override
  Future<void> addCommentToEvent(int userId, int eventId, CommentModel comment) async {
    http.post(Uri.parse('$baseUrl/ssfl/addComment?userId=$userId&eventId=$eventId'), body: comment);
  }

  @override
  Future<void> removeCommentToEvent(int userId, int eventId, int commentId) async {
    http.delete(Uri.parse('$baseUrl/ssfl/removeComment?userId=$userId&eventId=$eventId'));
  }

  @override
  Future<void> followOrganizer(int userId, int organizerId) async {
    http.get(Uri.parse('$baseUrl/ssfl/followOrganizer?userId=$userId&organizerId=$organizerId'));
  }

  @override
  Future<void> unfollowOrganizer(int userId, int organizerId) async {
    http.delete(Uri.parse('$baseUrl/ssfl/unfollowOrganizer?userId=$userId&organizerId=$organizerId'));
  }

  @override
  Future<void> addLikeToEvent(int userId, int eventId) async {
    http.get(Uri.parse('$baseUrl/ssfl/likeEvent?userId=$userId&eventId=$eventId'));
  }

  @override
  Future<void> removelikeEvent(int userId, int eventId) async {
    http.delete(Uri.parse('$baseUrl/ssfl/removeLikeEvent?userId=$userId&eventId=$eventId'));
  }

  @override
  Future<void> removeOrganizerEventToUserStore(int userId, int eventId) async {
    http.delete(Uri.parse('$baseUrl/ssfl/removeEventStore?userId=$userId&eventId=$eventId'));
  }

  @override
  Future<void> saveOrganizerEventToUserStore(int userId, int eventId) async {
    http.get(Uri.parse('$baseUrl/ssfl/saveEventStore?userId=$userId&eventId=$eventId'));
  }

  @override
  Future<List<CommentModel>> getCommentList(List<int>? commentIdList) async {
    final response = await networkManager.send<CommentModel, List<CommentModel>>('$baseUrl/ssfl/getComment',
        parseModel: CommentModel(), data: commentIdList, method: RequestType.GET);

    return response.data!;
  }
}
