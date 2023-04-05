import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends INetworkModel<UserModel> {
  int? id;
  String? firstName;
  String? lastName;
  String? birtDate;
  String? email;
  List<int>? byOrganized;
  String? imageURL;
  List<int>? likeList;
  List<int>? followOrganizer;
  List<int>? userEventStore;
  String? role;
  List<String>? ticketList;
  bool? organizer;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.birtDate,
      this.email,
      this.byOrganized,
      this.imageURL,
      this.likeList,
      this.followOrganizer,
      this.userEventStore,
      this.role,
      this.ticketList,
      this.organizer});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserModelToJson(this);
  }

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }
}

@JsonSerializable()
class TicketModel {
  String? id;
  String? name;
  String? imageUrl;
  String? description;
  String? createdDate;
  String? changedDate;
  String? status;
  int? price;

  TicketModel({this.id, this.name, this.imageUrl, this.description, this.createdDate, this.changedDate, this.status, this.price});

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return _$TicketModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TicketModelToJson(this);
  }
}
