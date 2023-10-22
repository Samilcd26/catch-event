// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      id: json['id'] as int?,
      userName: json['userName'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      birtDate: json['birtDate'] as String?,
      disLikeList: (json['disLikeList'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      email: json['email'] as String?,
      byOrganized: json['byOrganized'] == null
          ? null
          : OrganizerModel.fromJson(
              json['byOrganized'] as Map<String, dynamic>),
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
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'id': instance.id,
      'firstName': instance.firstName,
      'userName': instance.userName,
      'lastName': instance.lastName,
      'birtDate': instance.birtDate,
      'email': instance.email,
      'byOrganized': instance.byOrganized,
      'imageURL': instance.imageURL,
      'likeList': instance.likeList,
      'disLikeList': instance.disLikeList,
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

RegisterModel _$RegisterModelFromJson(Map<String, dynamic> json) =>
    RegisterModel(
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$RegisterModelToJson(RegisterModel instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'password': instance.password,
    };
