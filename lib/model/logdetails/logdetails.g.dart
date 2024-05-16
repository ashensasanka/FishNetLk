// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logdetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogDetails _$LogDetailsFromJson(Map<String, dynamic> json) => LogDetails(
      id: json['id'] as String?,
      name: json['name'] as String?,
      method: json['method'] as String?,
      lat: json['latitude'] as String?,
      long: json['longitude'] as String?,
      quantity: json['quantity'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$LogDetailsToJson(LogDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'method': instance.method,
      'latitude': instance.lat,
      'longitude': instance.long,
      'quantity': instance.quantity,
      'date': instance.date?.toIso8601String(),
    };
