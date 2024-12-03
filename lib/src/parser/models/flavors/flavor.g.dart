// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flavor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flavor _$FlavorFromJson(Map json) {
  $checkKeys(
    json,
    requiredKeys: const ['app'],
    disallowNullValues: const ['app', 'configs', 'android', 'ios', 'macos'],
  );
  return Flavor(
    app: App.fromJson(Map<String, dynamic>.from(json['app'] as Map)),
    configs: (json['configs'] as Map?)?.map(
      (k, e) => MapEntry(k as String, e as String),
    ),
    android: json['android'] == null
        ? null
        : Android.fromJson(Map<String, dynamic>.from(json['android'] as Map)),
    ios: json['ios'] == null
        ? null
        : Darwin.fromJson(Map<String, dynamic>.from(json['ios'] as Map)),
    macos: json['macos'] == null
        ? null
        : Darwin.fromJson(Map<String, dynamic>.from(json['macos'] as Map)),
  );
}
