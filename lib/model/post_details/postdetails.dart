import 'package:json_annotation/json_annotation.dart';
part 'postdetails.g.dart';

@JsonSerializable()
class PostDetails {
  @JsonKey(name:"id")
  String? id;

  @JsonKey(name:"image")
  String? image;

  @JsonKey(name:"description")
  String? description;

  @JsonKey(name:"filetype")
  String? filetype;

  @JsonKey(name:"from")
  String? from;

  @JsonKey(name:"title")
  String? title;

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"createDay")
  DateTime? createDay;

  PostDetails({
    this.id,
    this.image,
    this.description,
    this.filetype,
    this.from,
    this.title,
    this.email,
    this.createDay
  });

  factory PostDetails.fromJson(Map<String, dynamic> json) => _$PostDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PostDetailsToJson(this);

}