import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:threego/core/network/network_service.dart';
import 'package:vexana/vexana.dart';

import '../../../Data/Models/organizer_model.dart';
import '../ISSFLService.dart';
import '../../../globals.dart' as globals;

class SSFLService extends ISSFLService {
  SSFLService(INetworkManager networkManager) : super(networkManager);

  final String baseUrl = globals.apiUrl;
  final String apiKey = globals.apiKey;
  //? ///////////////////////////////////////////////////////////////////////////

  @override
  Future<http.Response> addCommentToEvent(int userId, int eventId, CommentModel comment) async {
    return await http.post(Uri.parse('$baseUrl/ssfl/addComment?userId=$userId&eventId=$eventId'),
        body: jsonEncode(comment.toJson()), headers: NetworkService.getHeader());
  }
  //? ///////////////////////////////////////////////////////////////////////////

  @override
  Future<http.Response> removeCommentToEvent(int userId, int eventId, int commentId) async {
    return await http.delete(Uri.parse('$baseUrl/ssfl/removeComment?userId=$userId&eventId=$eventId'), headers: NetworkService.getHeader());
  }

  //? ///////////////////////////////////////////////////////////////////////////

  @override
  Future<http.Response> followOrganizer(int userId, int organizerId) async {
    return await http.get(Uri.parse('$baseUrl/ssfl/followOrganizer?userId=$userId&organizerId=$organizerId'),
        headers: NetworkService.getHeader());
  }
  //? ///////////////////////////////////////////////////////////////////////////

  @override
  Future<http.Response> unfollowOrganizer(int userId, int organizerId) async {
    return await http.delete(Uri.parse('$baseUrl/ssfl/unfollowOrganizer?userId=$userId&organizerId=$organizerId'),
        headers: NetworkService.getHeader());
  }
  //? ///////////////////////////////////////////////////////////////////////////

  @override
  Future<http.Response> addLikeToEvent(int userId, int eventId) async {
    return await http.get(Uri.parse('$baseUrl/ssfl/likeEvent?userId=$userId&eventId=$eventId'), headers: NetworkService.getHeader());
  }
  //? ///////////////////////////////////////////////////////////////////////////

  @override
  Future<http.Response> removelikeEvent(int userId, int eventId) async {
    return await http.delete(Uri.parse('$baseUrl/ssfl/removeLikeEvent?userId=$userId&eventId=$eventId'),
        headers: NetworkService.getHeader());
  }
  //? ///////////////////////////////////////////////////////////////////////////

  @override
  Future<http.Response> addDislikeToEvent(int userId, int eventId) async {
    return await http.get(Uri.parse('$baseUrl/ssfl/dislikeEvent?userId=$userId&eventId=$eventId'), headers: NetworkService.getHeader());
  }
  //? ///////////////////////////////////////////////////////////////////////////

  @override
  Future<http.Response> removeDislikeEvent(int userId, int eventId) async {
    return await http.delete(Uri.parse('$baseUrl/ssfl/removeDislikeEvent?userId=$userId&eventId=$eventId'),
        headers: NetworkService.getHeader());
  }

  //? ///////////////////////////////////////////////////////////////////////////
  @override
  Future<http.Response> removeOrganizerEventToUserStore(int userId, int eventId) async {
    return await http.delete(Uri.parse('$baseUrl/ssfl/removeEventStore?userId=$userId&eventId=$eventId'),
        headers: NetworkService.getHeader());
  }
  //? ///////////////////////////////////////////////////////////////////////////

  @override
  Future<http.Response> saveOrganizerEventToUserStore(int userId, int eventId) async {
    return await http.get(Uri.parse('$baseUrl/ssfl/saveEventStore?userId=$userId&eventId=$eventId'), headers: NetworkService.getHeader());
  }
  //? ///////////////////////////////////////////////////////////////////////////

  @override
  Future<List<CommentModel>> getCommentList(List<int>? commentIdList) async {
    final response = await networkManager.send<CommentModel, List<CommentModel>>('$baseUrl/ssfl/getComment',
        parseModel: CommentModel(), data: commentIdList, method: RequestType.GET);

    return response.data!;
  }
  //? ///////////////////////////////////////////////////////////////////////////
}
