import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'organizer_model.g.dart';

@JsonSerializable()
class OrganizerModel extends INetworkModel<OrganizerModel> {
  int? id;
  String? email;
  String? title;
  String? description;
  String? image;
  String? openingHours;
  List<int>? followedList;
  List<int>? followerList;
  Address? address;
  List<Event>? event;

  OrganizerModel(
      {this.id,
      this.email,
      this.title,
      this.description,
      this.image,
      this.openingHours,
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
  int? postalCode;
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
class Event {
  int? id;
  int? organizerId;
  String? title;
  String? status;
  String? shortDescription;
  String? longDescription;
  double? price;
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
      this.status,
      this.shortDescription,
      this.longDescription,
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
}

@JsonSerializable()
class CommentModel extends INetworkModel<CommentModel> {
  int? id;
  int? byAddId;
  String? contents;
  List<int>? likeed;
  List<int>? subComment;
  String? createdDate;
  String? changedDate;

  CommentModel({this.id, this.byAddId, this.contents, this.likeed, this.subComment, this.createdDate, this.changedDate});

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
