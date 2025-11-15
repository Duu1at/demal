// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_tour_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingTourModel _$BookingTourModelFromJson(Map<String, dynamic> json) => BookingTourModel(
  id: json['id'] as String?,
  title: json['title'] as String?,
  mainImageUrl: json['mainImageUrl'] as String?,
  location: json['location'] as String?,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  time: json['time'] as String?,
  price: (json['price'] as num?)?.toInt(),
);

Map<String, dynamic> _$BookingTourModelToJson(BookingTourModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'mainImageUrl': instance.mainImageUrl,
  'location': instance.location,
  'date': instance.date?.toIso8601String(),
  'time': instance.time,
  'price': instance.price,
};
