// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
  success: json['success'] as bool,
  user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) => <String, dynamic>{
  'success': instance.success,
  'user': instance.user,
};

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  userId: json['userId'] as String?,
  phoneNumber: json['phone_number'] as String?,
  fullName: json['full_name'] as String?,
  role: json['role'] as String?,
  imageUrl: json['image_url'] as String?,
  createdAt: json['created_at'] as String?,
  partnerProfile: json['partnerProfile'] == null
      ? null
      : PartnerProfileModel.fromJson(
          json['partnerProfile'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'userId': instance.userId,
  'phone_number': instance.phoneNumber,
  'full_name': instance.fullName,
  'role': instance.role,
  'image_url': instance.imageUrl,
  'created_at': instance.createdAt,
  'partnerProfile': instance.partnerProfile,
};
