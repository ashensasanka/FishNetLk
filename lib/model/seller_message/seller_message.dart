import 'package:json_annotation/json_annotation.dart';
part 'seller_message.g.dart';

@JsonSerializable()
class SellerMessage {
  @JsonKey(name:"id")
  String? id;

  @JsonKey(name:"message")
  String? message;

  @JsonKey(name:"pressingTime")
  int? pressingTime;

  SellerMessage({
    this.id,
    this.message,
    this.pressingTime
  });

  factory SellerMessage.fromJson(Map<String, dynamic> json) => _$SellerMessageFromJson(json);

  Map<String, dynamic> toJson() => _$SellerMessageToJson(this);

}