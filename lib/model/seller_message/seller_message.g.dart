// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerMessage _$SellerMessageFromJson(Map<String, dynamic> json) =>
    SellerMessage(
      id: json['id'] as String?,
      message: json['message'] as String?,
      pressingTime: json['pressingTime'] as int?,
    );

Map<String, dynamic> _$SellerMessageToJson(SellerMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'pressingTime': instance.pressingTime,
    };
