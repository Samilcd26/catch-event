// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_organizer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterOrganizerModel _$FilterOrganizerModelFromJson(
        Map<String, dynamic> json) =>
    FilterOrganizerModel(
      json['eventType'] as String?,
      json['country'] as String?,
      json['city'] as String?,
      json['userId'] as int?,
      json['startDate'] as String?,
      json['endDate'] as String?,
      json['endHour'] as String?,
      json['startHour'] as String?,
      (json['selectCategory'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      json['online'] as bool?,
      json['onlyFollow'] as bool?,
      json['ticketNeed'] as bool?,
      json['free'] as bool?,
      json['verifyAccount'] as bool?,
      json['minPrice'] as int?,
      json['maxPrice'] as int?,
    );

Map<String, dynamic> _$FilterOrganizerModelToJson(
        FilterOrganizerModel instance) =>
    <String, dynamic>{
      'eventType': instance.eventType,
      'country': instance.country,
      'city': instance.city,
      'userId': instance.userId,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'startHour': instance.startHour,
      'endHour': instance.endHour,
      'selectCategory': instance.selectCategory,
      'online': instance.online,
      'onlyFollow': instance.onlyFollow,
      'ticketNeed': instance.ticketNeed,
      'free': instance.free,
      'verifyAccount': instance.verifyAccount,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
    };
