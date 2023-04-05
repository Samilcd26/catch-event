// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      birtDate: json['birtDate'] as String?,
      email: json['email'] as String?,
      byOrganized: (json['byOrganized'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      imageURL: json['imageURL'] as String?,
      likeList:
          (json['likeList'] as List<dynamic>?)?.map((e) => e as int).toList(),
      followOrganizer: (json['followOrganizer'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      userEventStore: (json['userEventStore'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      role: json['role'] as String?,
      ticketList: (json['ticketList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      organizer: json['organizer'] as bool?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birtDate': instance.birtDate,
      'email': instance.email,
      'byOrganized': instance.byOrganized,
      'imageURL': instance.imageURL,
      'likeList': instance.likeList,
      'followOrganizer': instance.followOrganizer,
      'userEventStore': instance.userEventStore,
      'role': instance.role,
      'ticketList': instance.ticketList,
      'organizer': instance.organizer,
    };

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      createdDate: json['createdDate'] as String?,
      changedDate: json['changedDate'] as String?,
      status: json['status'] as String?,
      price: json['price'] as int?,
    );

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'createdDate': instance.createdDate,
      'changedDate': instance.changedDate,
      'status': instance.status,
      'price': instance.price,
    };
