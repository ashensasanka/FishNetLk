import 'package:json_annotation/json_annotation.dart';
part 'logdetails.g.dart';

@JsonSerializable()
class LogDetails {
  @JsonKey(name:"id")
  String? id;

  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"method")
  String? method;

  @JsonKey(name:"latitude")
  String? lat;

  @JsonKey(name:"longitude")
  String? long;

  @JsonKey(name:"quantity")
  String? quantity;

  @JsonKey(name:"date")
  DateTime? date;

  LogDetails({
    this.id,
    this.name,
    this.method,
    this.lat,
    this.long,
    this.quantity,
    this.date,
  });

  factory LogDetails.fromJson(Map<String, dynamic> json) => _$LogDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$LogDetailsToJson(this);

}