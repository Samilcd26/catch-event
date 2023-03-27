import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'publisher_model.g.dart';

@JsonSerializable()
class PublisherModel extends INetworkModel<PublisherModel> {
  String? id;
  String? brand;
  String? image;
  String? description;
  String? openingHours;
  List<Address>? address;
  List<Event>? event;
  String? category;
  String? email;

  PublisherModel(
      {this.id, this.brand, this.image, this.description, this.openingHours, this.address, this.event, this.category, this.email});

  factory PublisherModel.fromJson(Map<String, dynamic> json) {
    return _$PublisherModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PublisherModelToJson(this);
  }

  @override
  PublisherModel fromJson(Map<String, dynamic> json) {
    return _$PublisherModelFromJson(json);
  }
}

@JsonSerializable()
class Address {
  String? id;
  int? postCode;
  String? country;
  String? eventUrl;
  String? state;
  String? city;
  String? streetName;
  String? district;
  String? neighbourhood;
  String? apartmentName;
  int? doorNumber;
  Coordinate? coordinate;
  bool? online;

  Address(
      {this.id,
      this.postCode,
      this.country,
      this.eventUrl,
      this.state,
      this.city,
      this.streetName,
      this.district,
      this.neighbourhood,
      this.apartmentName,
      this.doorNumber,
      this.coordinate,
      this.online});

  factory Address.fromJson(Map<String, dynamic> json) {
    return _$AddressFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddressToJson(this);
  }
}

@JsonSerializable()
class Coordinate {
  String? id;
  double? latitude;
  double? longitude;

  Coordinate({this.id, this.latitude, this.longitude});

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return _$CoordinateFromJson(json);
  }

  LatLng toLatLng() {
    return LatLng(latitude!, longitude!);
  }

  Map<String, dynamic> toJson() {
    return _$CoordinateToJson(this);
  }
}

@JsonSerializable()
class Event {
  String? id;
  String? title;
  String? description;
  double? price;
  String? image;
  String? category;
  int? likeScore;
  int? likePerson;
  List<Address>? address;
  List<DateTime>? date;

  Event(
      {this.id,
      this.title,
      this.category,
      this.description,
      this.price,
      this.image,
      this.likeScore,
      this.likePerson,
      this.address,
      this.date});

  factory Event.fromJson(Map<String, dynamic> json) {
    return _$EventFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EventToJson(this);
  }
}
