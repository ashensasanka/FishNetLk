// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatdetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatDetails _$ChatDetailsFromJson(Map<String, dynamic> json) => ChatDetails(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      birthDay: json['birthDay'] == null
          ? null
          : DateTime.parse(json['birthDay'] as String),
      gender: json['gender'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ChatDetailsToJson(ChatDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'birthDay': instance.birthDay?.toIso8601String(),
      'gender': instance.gender,
      'image': instance.image,
    };
