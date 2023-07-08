// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organizer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizerModel _$OrganizerModelFromJson(Map<String, dynamic> json) =>
    OrganizerModel(
      id: json['id'] as int?,
      organizerName: json['organizerName'] as String?,
      email: json['email'] as String?,
      title: json['title'] as String?,
      eventLimit: json['eventLimit'] as int?,
      eventLimitRefreshDate: json['eventLimitRefreshDate'] == null
          ? null
          : DateTime.parse(json['eventLimitRefreshDate'] as String),
      verify: json['verify'] as bool?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      followedList: (json['followedList'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      followerList: (json['followerList'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      address: (json['address'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      event: (json['event'] as List<dynamic>?)
          ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrganizerModelToJson(OrganizerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'title': instance.title,
      'verify': instance.verify,
      'description': instance.description,
      'image': instance.image,
      'organizerName': instance.organizerName,
      'eventLimit': instance.eventLimit,
      'eventLimitRefreshDate':
          instance.eventLimitRefreshDate?.toIso8601String(),
      'followedList': instance.followedList,
      'followerList': instance.followerList,
      'address': instance.address,
      'event': instance.event,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as int?,
      postalCode: json['postalCode'] as String?,
      country: json['country'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      coordinate: json['coordinate'] == null
          ? null
          : Coordinate.fromJson(json['coordinate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'postalCode': instance.postalCode,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'district': instance.district,
      'address1': instance.address1,
      'address2': instance.address2,
      'coordinate': instance.coordinate,
    };

Coordinate _$CoordinateFromJson(Map<String, dynamic> json) => Coordinate(
      id: json['id'] as int?,
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
      id: json['id'] as int?,
      organizerId: json['organizerId'] as int?,
      title: json['title'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      description: json['description'] as String?,
      price: json['price'] as int?,
      currency: json['currency'] as String?,
      onlineEventUrl: json['onlineEventUrl'] as String?,
      eventPlatform: json['eventPlatform'] as String?,
      capacity: json['capacity'] as int?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      changedDate: json['changedDate'] == null
          ? null
          : DateTime.parse(json['changedDate'] as String),
      published: json['published'] as String?,
      imageUrl: json['imageUrl'] as String?,
      eventDateTime: (json['eventDateTime'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      eventTag: (json['eventTag'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      likeScore: (json['likeScore'] as List<dynamic>?)
          ?.map((e) => (e as Map<String, dynamic>).map(
                (k, e) => MapEntry(int.parse(k), e as int),
              ))
          .toList(),
      eventPartners: (json['eventPartners'] as List<dynamic>?)
          ?.map((e) => EventPartner.fromJson(e as Map<String, dynamic>))
          .toList(),
      commentList: (json['commentList'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      category: json['category'] as String?,
      address: (json['address'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      online: json['online'] as bool?,
      ticketNeed: json['ticketNeed'] as bool?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'organizerId': instance.organizerId,
      'title': instance.title,
      'type': instance.type,
      'status': instance.status,
      'description': instance.description,
      'price': instance.price,
      'currency': instance.currency,
      'onlineEventUrl': instance.onlineEventUrl,
      'eventPlatform': instance.eventPlatform,
      'capacity': instance.capacity,
      'createdDate': instance.createdDate?.toIso8601String(),
      'changedDate': instance.changedDate?.toIso8601String(),
      'published': instance.published,
      'imageUrl': instance.imageUrl,
      'eventDateTime':
          instance.eventDateTime?.map((e) => e.toIso8601String()).toList(),
      'eventTag': instance.eventTag,
      'likeScore': instance.likeScore
          ?.map((e) => e.map((k, e) => MapEntry(k.toString(), e)))
          .toList(),
      'eventPartners': instance.eventPartners,
      'commentList': instance.commentList,
      'category': instance.category,
      'address': instance.address,
      'online': instance.online,
      'ticketNeed': instance.ticketNeed,
    };

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] as int?,
      addedUsersImage: json['addedUsersImage'] as String?,
      addedUsersName: json['addedUsersName'] as String?,
      addedUsersId: json['addedUsersId'] as int?,
      contents: json['contents'] as String?,
      likeed: (json['likeed'] as List<dynamic>?)?.map((e) => e as int).toList(),
      subComment:
          (json['subComment'] as List<dynamic>?)?.map((e) => e as int).toList(),
      createdDate: json['createdDate'] as String?,
      changedDate: json['changedDate'] as String?,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'addedUsersId': instance.addedUsersId,
      'contents': instance.contents,
      'addedUsersName': instance.addedUsersName,
      'addedUsersImage': instance.addedUsersImage,
      'likeed': instance.likeed,
      'subComment': instance.subComment,
      'createdDate': instance.createdDate,
      'changedDate': instance.changedDate,
    };

EventPartner _$EventPartnerFromJson(Map<String, dynamic> json) => EventPartner(
      id: json['id'] as int?,
      imageUrl: json['imageUrl'] as String?,
      name: json['name'] as String?,
      about: json['about'] as String?,
      aboutLink: json['aboutLink'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$EventPartnerToJson(EventPartner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'about': instance.about,
      'aboutLink': instance.aboutLink,
      'category': instance.category,
    };
