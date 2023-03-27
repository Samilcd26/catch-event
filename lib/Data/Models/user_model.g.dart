// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      birtDate: json['birtDate'] as String?,
      email: json['email'] as String?,
      imageURL: json['imageURL'] as String?,
      likeList: (json['likeList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      role: json['role'] as String?,
      ticketList: (json['ticketList'] as List<dynamic>?)
          ?.map((e) => TicketList.fromJson(e as Map<String, dynamic>))
          .toList(),
      flowPublisher: (json['flowPublisher'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      publisher: json['publisher'] as bool?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birtDate': instance.birtDate,
      'email': instance.email,
      'imageURL': instance.imageURL,
      'likeList': instance.likeList,
      'role': instance.role,
      'ticketList': instance.ticketList,
      'flowPublisher': instance.flowPublisher,
      'publisher': instance.publisher,
    };

TicketList _$TicketListFromJson(Map<String, dynamic> json) => TicketList(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      createdDate: json['createdDate'] as String?,
      status: json['status'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$TicketListToJson(TicketList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdDate': instance.createdDate,
      'status': instance.status,
      'token': instance.token,
    };
