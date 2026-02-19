import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
final class AppVersionConfigModel extends Equatable {
  const AppVersionConfigModel({
    required this.android,
    required this.ios,
  });

  factory AppVersionConfigModel.fromJson(Map<String, dynamic> json) {
    return AppVersionConfigModel(
      android: AppVersionRequirementModel.fromJson(json['android'] as Map<String, dynamic>),
      ios: AppVersionRequirementModel.fromJson(json['ios'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'android': android.toJson(),
      'ios': ios.toJson(),
    };
  }

  final AppVersionRequirementModel android;
  final AppVersionRequirementModel ios;

  @override
  List<Object?> get props => [android, ios];
}
