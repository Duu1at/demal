import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class AppVersionRequirementModel extends Equatable {
  const AppVersionRequirementModel({
    required this.requiredBuildNumber,
    required this.recommendedBuildNumber,
  });
  factory AppVersionRequirementModel.fromJson(Map<String, dynamic> json) {
    return AppVersionRequirementModel(
      requiredBuildNumber: json['requiredBuildNumber'] as int,
      recommendedBuildNumber: json['recommendedBuildNumber'] as int,
    );
  }

  final int requiredBuildNumber;
  final int recommendedBuildNumber;

  bool isVersionSupported(int currentBuildNumber) {
    return currentBuildNumber >= requiredBuildNumber;
  }

  bool isUpdateRecommended(int currentBuildNumber) {
    return currentBuildNumber < recommendedBuildNumber;
  }

  bool isUpdateRequired(int currentBuildNumber) {
    return currentBuildNumber < requiredBuildNumber;
  }

  Map<String, dynamic> toJson() {
    return {
      'requiredBuildNumber': requiredBuildNumber,
      'recommendedBuildNumber': recommendedBuildNumber,
    };
  }

  @override
  List<Object?> get props => [requiredBuildNumber, recommendedBuildNumber];
}
