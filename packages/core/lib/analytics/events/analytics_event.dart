import 'package:flutter/material.dart';

@immutable
final class AnalyticsEvent {
  const AnalyticsEvent({
    required this.name,
    this.parameters,
  });

  final String name;
  final Map<String, Object>? parameters;
}
