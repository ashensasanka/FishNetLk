// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postdetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetails _$PostDetailsFromJson(Map<String, dynamic> json) => PostDetails(
      id: json['id'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      filetype: json['filetype'] as String?,
      from: json['from'] as String?,
      title: json['title'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$PostDetailsToJson(PostDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'description': instance.description,
      'filetype': instance.filetype,
      'from': instance.from,
      'title': instance.title,
      'email': instance.email,
    };
