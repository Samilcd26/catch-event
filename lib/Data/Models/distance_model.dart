import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'distance_model.g.dart';

@JsonSerializable()
class DistanceModel extends INetworkModel<DistanceModel> {
  List<String>? destinationAddresses;
  List<String>? originAddresses;
  List<Rows>? rows;
  String? status;

  DistanceModel({this.destinationAddresses, this.originAddresses, this.rows, this.status});

  factory DistanceModel.fromJson(Map<String, dynamic> json) {
    return _$DistanceModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DistanceModelToJson(this);
  }

  @override
  DistanceModel fromJson(Map<String, dynamic> json) {
    return _$DistanceModelFromJson(json);
  }
}

@JsonSerializable()
class Rows {
  List<Elements>? elements;

  Rows({this.elements});

  factory Rows.fromJson(Map<String, dynamic> json) {
    return _$RowsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RowsToJson(this);
  }
}

@JsonSerializable()
class Elements {
  Distance? distance;
  Distance? duration;
  String? status;

  Elements({this.distance, this.duration, this.status});

  factory Elements.fromJson(Map<String, dynamic> json) {
    return _$ElementsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ElementsToJson(this);
  }
}

@JsonSerializable()
class Distance {
  String? text;
  int? value;

  Distance({this.text, this.value});

  factory Distance.fromJson(Map<String, dynamic> json) {
    return _$DistanceFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DistanceToJson(this);
  }
}
