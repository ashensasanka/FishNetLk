// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatfetch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatFetchDetails _$ChatFetchDetailsFromJson(Map<String, dynamic> json) =>
    ChatFetchDetails(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      birthDay: json['birthDay'] as String?,
      gender: json['gender'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ChatFetchDetailsToJson(ChatFetchDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'birthDay': instance.birthDay,
      'gender': instance.gender,
      'image': instance.image,
    };
