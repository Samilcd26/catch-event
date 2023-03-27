import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends INetworkModel<UserModel> {
  String? id;
  String? firstName;
  String? lastName;
  String? birtDate;
  String? email;
  String? imageURL;
  List<String>? likeList;
  String? role;
  List<TicketList>? ticketList;
  List<String>? flowPublisher;
  bool? publisher;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.birtDate,
      this.email,
      this.imageURL,
      this.likeList,
      this.role,
      this.ticketList,
      this.flowPublisher,
      this.publisher});

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
class TicketList {
  String? id;
  String? name;
  String? description;
  String? createdDate;
  String? status;
  String? token;

  TicketList({this.id, this.name, this.description, this.createdDate, this.status, this.token});

  factory TicketList.fromJson(Map<String, dynamic> json) {
    return _$TicketListFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TicketListToJson(this);
  }
}
