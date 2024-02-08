import 'package:json_annotation/json_annotation.dart';
part 'chatdetails.g.dart';

@JsonSerializable()
class ChatDetails {
  @JsonKey(name:"id")
  String? id;

  @JsonKey(name:"fullName")
  String? fullName;

  @JsonKey(name:"birthDay")
  DateTime? birthDay;

  @JsonKey(name:"gender")
  String? gender;

  @JsonKey(name:"image")
  String? image;


  ChatDetails({
    this.id,
    this.fullName,
    this.birthDay,
    this.gender,
    this.image
  });

  factory ChatDetails.fromJson(Map<String, dynamic> json) => _$ChatDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ChatDetailsToJson(this);

}