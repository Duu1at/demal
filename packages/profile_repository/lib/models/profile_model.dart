import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'profile_model.g.dart';

@JsonSerializable()
@immutable
final class ProfileModel {
  const ProfileModel({
    required this.success,
    required this.user,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);

  final bool success;
  final UserModel user;

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
