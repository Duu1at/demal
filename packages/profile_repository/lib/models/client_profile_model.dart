import 'package:auth_repository/auth_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'client_profile_model.g.dart';

@JsonSerializable()
@immutable
final class ClientProfileModel {
  const ClientProfileModel({
    required this.success,
    required this.user,
  });

  factory ClientProfileModel.fromJson(Map<String, dynamic> json) => _$ClientProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ClientProfileModelToJson(this);

  final bool success;
  final UserModel user;
}
