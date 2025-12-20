// This is a generated file - do not edit.
//
// Generated from common/health.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class HealthReport extends $pb.GeneratedMessage {
  factory HealthReport({
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? components,
    $core.bool? healthy,
  }) {
    final result = create();
    if (components != null) result.components.addEntries(components);
    if (healthy != null) result.healthy = healthy;
    return result;
  }

  HealthReport._();

  factory HealthReport.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HealthReport.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HealthReport',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.health'),
      createEmptyInstance: create)
    ..m<$core.String, $core.String>(1, _omitFieldNames ? '' : 'components',
        entryClassName: 'HealthReport.ComponentsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('common.health'))
    ..aOB(2, _omitFieldNames ? '' : 'healthy')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthReport clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthReport copyWith(void Function(HealthReport) updates) =>
      super.copyWith((message) => updates(message as HealthReport))
          as HealthReport;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HealthReport create() => HealthReport._();
  @$core.override
  HealthReport createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HealthReport getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HealthReport>(create);
  static HealthReport? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.String, $core.String> get components => $_getMap(0);

  @$pb.TagNumber(2)
  $core.bool get healthy => $_getBF(1);
  @$pb.TagNumber(2)
  set healthy($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasHealthy() => $_has(1);
  @$pb.TagNumber(2)
  void clearHealthy() => $_clearField(2);
}

class StatusInfo extends $pb.GeneratedMessage {
  factory StatusInfo({
    $core.String? name,
    $core.String? version,
    $core.double? uptime,
    $core.String? env,
    $core.String? timestamp,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (version != null) result.version = version;
    if (uptime != null) result.uptime = uptime;
    if (env != null) result.env = env;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  StatusInfo._();

  factory StatusInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StatusInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StatusInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.health'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'version')
    ..aD(4, _omitFieldNames ? '' : 'uptime')
    ..aOS(5, _omitFieldNames ? '' : 'env')
    ..aOS(6, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatusInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatusInfo copyWith(void Function(StatusInfo) updates) =>
      super.copyWith((message) => updates(message as StatusInfo)) as StatusInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StatusInfo create() => StatusInfo._();
  @$core.override
  StatusInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StatusInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StatusInfo>(create);
  static StatusInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get version => $_getSZ(1);
  @$pb.TagNumber(2)
  set version($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => $_clearField(2);

  @$pb.TagNumber(4)
  $core.double get uptime => $_getN(2);
  @$pb.TagNumber(4)
  set uptime($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(4)
  $core.bool hasUptime() => $_has(2);
  @$pb.TagNumber(4)
  void clearUptime() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get env => $_getSZ(3);
  @$pb.TagNumber(5)
  set env($core.String value) => $_setString(3, value);
  @$pb.TagNumber(5)
  $core.bool hasEnv() => $_has(3);
  @$pb.TagNumber(5)
  void clearEnv() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get timestamp => $_getSZ(4);
  @$pb.TagNumber(6)
  set timestamp($core.String value) => $_setString(4, value);
  @$pb.TagNumber(6)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(6)
  void clearTimestamp() => $_clearField(6);
}

class LiveStatus extends $pb.GeneratedMessage {
  factory LiveStatus({
    $core.bool? live,
  }) {
    final result = create();
    if (live != null) result.live = live;
    return result;
  }

  LiveStatus._();

  factory LiveStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LiveStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LiveStatus',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.health'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'live')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LiveStatus clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LiveStatus copyWith(void Function(LiveStatus) updates) =>
      super.copyWith((message) => updates(message as LiveStatus)) as LiveStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LiveStatus create() => LiveStatus._();
  @$core.override
  LiveStatus createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LiveStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LiveStatus>(create);
  static LiveStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get live => $_getBF(0);
  @$pb.TagNumber(1)
  set live($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLive() => $_has(0);
  @$pb.TagNumber(1)
  void clearLive() => $_clearField(1);
}

class ReadyStatus extends $pb.GeneratedMessage {
  factory ReadyStatus({
    $core.bool? ready,
  }) {
    final result = create();
    if (ready != null) result.ready = ready;
    return result;
  }

  ReadyStatus._();

  factory ReadyStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReadyStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReadyStatus',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.health'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'ready')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadyStatus clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadyStatus copyWith(void Function(ReadyStatus) updates) =>
      super.copyWith((message) => updates(message as ReadyStatus))
          as ReadyStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReadyStatus create() => ReadyStatus._();
  @$core.override
  ReadyStatus createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReadyStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReadyStatus>(create);
  static ReadyStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get ready => $_getBF(0);
  @$pb.TagNumber(1)
  set ready($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReady() => $_has(0);
  @$pb.TagNumber(1)
  void clearReady() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
