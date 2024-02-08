import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chatfetch.g.dart';

@JsonSerializable()
class ChatFetchDetails {
  @JsonKey(name:"id")
  String? id;

  @JsonKey(name:"fullName")
  String? fullName;

  @JsonKey(name:"birthDay")
  String? birthDay;

  @JsonKey(name:"gender")
  String? gender;

  @JsonKey(name:"image")
  String? image;


  ChatFetchDetails({
    this.id,
    this.fullName,
    this.birthDay,
    this.gender,
    this.image
  });

  factory ChatFetchDetails.fromJson(Map<String, dynamic> json) => _$ChatFetchDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ChatFetchDetailsToJson(this);

}