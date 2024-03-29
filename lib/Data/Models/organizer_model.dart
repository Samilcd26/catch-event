import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'organizer_model.g.dart';

@JsonSerializable()
class OrganizerModel extends INetworkModel<OrganizerModel> {
  int? id;
  String? email;
  String? title;
  bool? verify;
  String? description;
  String? image;
  String? organizerName;

  int? eventLimit;
  DateTime? eventLimitRefreshDate;
  List<int>? followedList;
  List<int>? followerList;
  List<Address>? address;
  List<Event>? event;

  OrganizerModel(
      {this.id,
      this.organizerName,
      this.email,
      this.title,
      this.eventLimit,
      this.eventLimitRefreshDate,
      this.verify,
      this.description,
      this.image,
      this.followedList,
      this.followerList,
      this.address,
      this.event});

  factory OrganizerModel.fromJson(Map<String, dynamic> json) {
    return _$OrganizerModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrganizerModelToJson(this);
  }

  @override
  OrganizerModel fromJson(Map<String, dynamic> json) {
    return _$OrganizerModelFromJson(json);
  }
}

@JsonSerializable()
class Address {
  int? id;
  String? postalCode;
  String? country;
  String? state;
  String? city;
  String? district;
  String? address1;
  String? address2;
  Coordinate? coordinate;

  Address({this.id, this.postalCode, this.country, this.state, this.city, this.district, this.address1, this.address2, this.coordinate});

  factory Address.fromJson(Map<String, dynamic> json) {
    return _$AddressFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddressToJson(this);
  }
}

@JsonSerializable()
class Coordinate {
  int? id;
  double? latitude;
  double? longitude;

  Coordinate({this.id, this.latitude, this.longitude});

  LatLng toLatLng() {
    return LatLng(latitude!, longitude!);
  }

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return _$CoordinateFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CoordinateToJson(this);
  }
}

@JsonSerializable()
class Event extends INetworkModel<Event> {
  int? id;
  int? organizerId;
  String? title;
  String? type;
  String? status;
  String? description;
  int? price;
  String? currency;
  String? onlineEventUrl;
  String? eventPlatform;
  int? capacity;
  DateTime? createdDate;
  DateTime? changedDate;
  String? published;
  String? imageUrl;
  List<DateTime>? eventDateTime;
  List<String>? eventTag;
  // Hata Olabilir
  List<Map<int, int>>? likeScore;
  List<EventPartner>? eventPartners;
  //
  List<int>? commentList;
  String? category;
  List<Address>? address;
  bool? online;
  bool? ticketNeed;

  Event(
      {this.id,
      this.organizerId,
      this.title,
      this.type,
      this.status,
      this.description,
      this.price,
      this.currency,
      this.onlineEventUrl,
      this.eventPlatform,
      this.capacity,
      this.createdDate,
      this.changedDate,
      this.published,
      this.imageUrl,
      this.eventDateTime,
      this.eventTag,
      this.likeScore,
      this.eventPartners,
      this.commentList,
      this.category,
      this.address,
      this.online,
      this.ticketNeed});

  factory Event.fromJson(Map<String, dynamic> json) {
    return _$EventFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EventToJson(this);
  }

  @override
  Event fromJson(Map<String, dynamic> json) {
    return _$EventFromJson(json);
  }
}

@JsonSerializable()
class CommentModel extends INetworkModel<CommentModel> {
  int? id;
  int? addedUsersId;
  String? contents;
  String? addedUsersName;
  String? addedUsersImage;
  List<int>? likeed;
  List<int>? subComment;
  String? createdDate;
  String? changedDate;

  CommentModel(
      {this.id,
      this.addedUsersImage,
      this.addedUsersName,
      this.addedUsersId,
      this.contents,
      this.likeed,
      this.subComment,
      this.createdDate,
      this.changedDate});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return _$CommentModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CommentModelToJson(this);
  }

  @override
  CommentModel fromJson(Map<String, dynamic> json) {
    return _$CommentModelFromJson(json);
  }
}

@JsonSerializable()
class EventPartner {
  int? id;
  String? imageUrl;
  String? name;
  String? about;
  String? aboutLink;
  String? category;

  EventPartner({this.id, this.imageUrl, this.name, this.about, this.aboutLink, this.category});

  factory EventPartner.fromJson(Map<String, dynamic> json) {
    return _$EventPartnerFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EventPartnerToJson(this);
  }
}
