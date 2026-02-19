import 'dart:core';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class RemoteConfigModel extends Equatable {
  const RemoteConfigModel({
    required this.technicalBreak,
    required this.appVersion,
  });

  factory RemoteConfigModel.empty() {
    return const RemoteConfigModel(
      technicalBreak: false,
      appVersion: AppVersionConfigModel(
        android: AppVersionRequirementModel(
          requiredBuildNumber: 0,
          recommendedBuildNumber: 0,
        ),
        ios: AppVersionRequirementModel(
          requiredBuildNumber: 0,
          recommendedBuildNumber: 0,
        ),
      ),
    );
  }

  final bool technicalBreak;
  final AppVersionConfigModel appVersion;


  bool isUpdateRequired(String platform, int currentBuildNumber) {
    if (platform.toLowerCase() == 'android') {
      return appVersion.android.isUpdateRequired(currentBuildNumber);
    } else if (platform.toLowerCase() == 'ios') {
      return appVersion.ios.isUpdateRequired(currentBuildNumber);
    }
    return false;
  }

  bool isUpdateRecommended(String platform, int currentBuildNumber) {
    if (platform.toLowerCase() == 'android') {
      return appVersion.android.isUpdateRecommended(currentBuildNumber);
    } else if (platform.toLowerCase() == 'ios') {
      return appVersion.ios.isUpdateRecommended(currentBuildNumber);
    }
    return false;
  }

  RemoteConfigModel copyWith({
    bool? technicalBreak,
    bool? accountReceipt,
    AppVersionConfigModel? appVersion,
  }) {
    return RemoteConfigModel(
      technicalBreak: technicalBreak ?? this.technicalBreak,
      appVersion: appVersion ?? this.appVersion,
    );
  }

  @override
  List<Object?> get props => [
    technicalBreak,
    appVersion,
  ];
}
