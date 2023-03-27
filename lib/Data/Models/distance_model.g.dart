// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistanceModel _$DistanceModelFromJson(Map<String, dynamic> json) =>
    DistanceModel(
      destinationAddresses: (json['destinationAddresses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      originAddresses: (json['originAddresses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => Rows.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$DistanceModelToJson(DistanceModel instance) =>
    <String, dynamic>{
      'destinationAddresses': instance.destinationAddresses,
      'originAddresses': instance.originAddresses,
      'rows': instance.rows,
      'status': instance.status,
    };

Rows _$RowsFromJson(Map<String, dynamic> json) => Rows(
      elements: (json['elements'] as List<dynamic>?)
          ?.map((e) => Elements.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RowsToJson(Rows instance) => <String, dynamic>{
      'elements': instance.elements,
    };

Elements _$ElementsFromJson(Map<String, dynamic> json) => Elements(
      distance: json['distance'] == null
          ? null
          : Distance.fromJson(json['distance'] as Map<String, dynamic>),
      duration: json['duration'] == null
          ? null
          : Distance.fromJson(json['duration'] as Map<String, dynamic>),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ElementsToJson(Elements instance) => <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'status': instance.status,
    };

Distance _$DistanceFromJson(Map<String, dynamic> json) => Distance(
      text: json['text'] as String?,
      value: json['value'] as int?,
    );

Map<String, dynamic> _$DistanceToJson(Distance instance) => <String, dynamic>{
      'text': instance.text,
      'value': instance.value,
    };
