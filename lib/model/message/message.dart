import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';

@JsonSerializable()
class Message {
  @JsonKey(name:"id")
  String? id;

  @JsonKey(name:"message")
  String? message;

  @JsonKey(name:"pressingTime")
  int? pressingTime;

  Message({
    this.id,
    this.message,
    this.pressingTime
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

}