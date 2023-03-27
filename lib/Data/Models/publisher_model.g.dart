// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publisher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublisherModel _$PublisherModelFromJson(Map<String, dynamic> json) =>
    PublisherModel(
      id: json['id'] as String?,
      brand: json['brand'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      openingHours: json['openingHours'] as String?,
      address: (json['address'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      event: (json['event'] as List<dynamic>?)
          ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
      category: json['category'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$PublisherModelToJson(PublisherModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brand': instance.brand,
      'image': instance.image,
      'description': instance.description,
      'openingHours': instance.openingHours,
      'address': instance.address,
      'event': instance.event,
      'category': instance.category,
      'email': instance.email,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as String?,
      postCode: json['postCode'] as int?,
      country: json['country'] as String?,
      eventUrl: json['eventUrl'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      streetName: json['streetName'] as String?,
      district: json['district'] as String?,
      neighbourhood: json['neighbourhood'] as String?,
      apartmentName: json['apartmentName'] as String?,
      doorNumber: json['doorNumber'] as int?,
      coordinate: json['coordinate'] == null
          ? null
          : Coordinate.fromJson(json['coordinate'] as Map<String, dynamic>),
      online: json['online'] as bool?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'postCode': instance.postCode,
      'country': instance.country,
      'eventUrl': instance.eventUrl,
      'state': instance.state,
      'city': instance.city,
      'streetName': instance.streetName,
      'district': instance.district,
      'neighbourhood': instance.neighbourhood,
      'apartmentName': instance.apartmentName,
      'doorNumber': instance.doorNumber,
      'coordinate': instance.coordinate,
      'online': instance.online,
    };

Coordinate _$CoordinateFromJson(Map<String, dynamic> json) => Coordinate(
      id: json['id'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CoordinateToJson(Coordinate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as String?,
      title: json['title'] as String?,
      category: json['category'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      image: json['image'] as String?,
      likeScore: json['likeScore'] as int?,
      likePerson: json['likePerson'] as int?,
      address: (json['address'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      date: (json['date'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'image': instance.image,
      'category': instance.category,
      'likeScore': instance.likeScore,
      'likePerson': instance.likePerson,
      'address': instance.address,
      'date': instance.date?.map((e) => e.toIso8601String()).toList(),
    };
