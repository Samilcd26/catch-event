import 'package:json_annotation/json_annotation.dart';

part 'filter_organizer_model.g.dart';

@JsonSerializable()
class FilterOrganizerModel {
  String? country;
  String? city;
  int? userId;
  String? startDate;
  String? endDate;
  String? startHour;
  String? endHour;
  List<String>? selectCategory;
  bool? online;
  bool? onlyFollow;
  bool? ticketNeed;
  bool? free;
  bool? verifyAccount;
  int? minPrice;
  int? maxPrice;

  FilterOrganizerModel(
    this.country,
    this.city,
    this.userId,
    this.startDate,
    this.endDate,
    this.endHour,
    this.startHour,
    this.selectCategory,
    this.online,
    this.onlyFollow,
    this.ticketNeed,
    this.free,
    this.verifyAccount,
    this.minPrice,
    this.maxPrice,
  );

  factory FilterOrganizerModel.fromJson(Map<String, dynamic> json) {
    return _$FilterOrganizerModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$FilterOrganizerModelToJson(this);
  }
}
