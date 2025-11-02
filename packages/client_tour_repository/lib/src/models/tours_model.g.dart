// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tours_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToursModel _$ToursModelFromJson(Map<String, dynamic> json) => ToursModel(
  id: json['id'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  image: json['image'] as String?,
  price: json['price'] as String?,
  duration: json['duration'] as String?,
  difficulty: json['difficulty'] as String?,
  location: json['location'] as String?,
);

Map<String, dynamic> _$ToursModelToJson(ToursModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'price': instance.price,
      'duration': instance.duration,
      'difficulty': instance.difficulty,
      'location': instance.location,
    };
