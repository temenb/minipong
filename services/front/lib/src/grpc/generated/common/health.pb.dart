//
//  Generated code. Do not modify.
//  source: common/health.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class HealthReport extends $pb.GeneratedMessage {
  factory HealthReport({
    $core.Map<$core.String, $core.String>? components,
    $core.bool? healthy,
  }) {
    final $result = create();
    if (components != null) {
      $result.components.addAll(components);
    }
    if (healthy != null) {
      $result.healthy = healthy;
    }
    return $result;
  }
  HealthReport._() : super();
  factory HealthReport.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthReport.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HealthReport', package: const $pb.PackageName(_omitMessageNames ? '' : 'common.health'), createEmptyInstance: create)
    ..m<$core.String, $core.String>(1, _omitFieldNames ? '' : 'components', entryClassName: 'HealthReport.ComponentsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('common.health'))
    ..aOB(2, _omitFieldNames ? '' : 'healthy')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HealthReport clone() => HealthReport()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HealthReport copyWith(void Function(HealthReport) updates) => super.copyWith((message) => updates(message as HealthReport)) as HealthReport;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HealthReport create() => HealthReport._();
  HealthReport createEmptyInstance() => create();
  static $pb.PbList<HealthReport> createRepeated() => $pb.PbList<HealthReport>();
  @$core.pragma('dart2js:noInline')
  static HealthReport getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HealthReport>(create);
  static HealthReport? _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.String, $core.String> get components => $_getMap(0);

  @$pb.TagNumber(2)
  $core.bool get healthy => $_getBF(1);
  @$pb.TagNumber(2)
  set healthy($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHealthy() => $_has(1);
  @$pb.TagNumber(2)
  void clearHealthy() => clearField(2);
}

class StatusInfo extends $pb.GeneratedMessage {
  factory StatusInfo({
    $core.String? name,
    $core.String? version,
    $core.double? uptime,
    $core.String? env,
    $core.String? timestamp,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (version != null) {
      $result.version = version;
    }
    if (uptime != null) {
      $result.uptime = uptime;
    }
    if (env != null) {
      $result.env = env;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    return $result;
  }
  StatusInfo._() : super();
  factory StatusInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StatusInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StatusInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'common.health'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'version')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'uptime', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'env')
    ..aOS(6, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StatusInfo clone() => StatusInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StatusInfo copyWith(void Function(StatusInfo) updates) => super.copyWith((message) => updates(message as StatusInfo)) as StatusInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StatusInfo create() => StatusInfo._();
  StatusInfo createEmptyInstance() => create();
  static $pb.PbList<StatusInfo> createRepeated() => $pb.PbList<StatusInfo>();
  @$core.pragma('dart2js:noInline')
  static StatusInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StatusInfo>(create);
  static StatusInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get version => $_getSZ(1);
  @$pb.TagNumber(2)
  set version($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);

  @$pb.TagNumber(4)
  $core.double get uptime => $_getN(2);
  @$pb.TagNumber(4)
  set uptime($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasUptime() => $_has(2);
  @$pb.TagNumber(4)
  void clearUptime() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get env => $_getSZ(3);
  @$pb.TagNumber(5)
  set env($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasEnv() => $_has(3);
  @$pb.TagNumber(5)
  void clearEnv() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get timestamp => $_getSZ(4);
  @$pb.TagNumber(6)
  set timestamp($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(6)
  void clearTimestamp() => clearField(6);
}

class LiveStatus extends $pb.GeneratedMessage {
  factory LiveStatus({
    $core.bool? live,
  }) {
    final $result = create();
    if (live != null) {
      $result.live = live;
    }
    return $result;
  }
  LiveStatus._() : super();
  factory LiveStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LiveStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LiveStatus', package: const $pb.PackageName(_omitMessageNames ? '' : 'common.health'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'live')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LiveStatus clone() => LiveStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LiveStatus copyWith(void Function(LiveStatus) updates) => super.copyWith((message) => updates(message as LiveStatus)) as LiveStatus;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LiveStatus create() => LiveStatus._();
  LiveStatus createEmptyInstance() => create();
  static $pb.PbList<LiveStatus> createRepeated() => $pb.PbList<LiveStatus>();
  @$core.pragma('dart2js:noInline')
  static LiveStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LiveStatus>(create);
  static LiveStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get live => $_getBF(0);
  @$pb.TagNumber(1)
  set live($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLive() => $_has(0);
  @$pb.TagNumber(1)
  void clearLive() => clearField(1);
}

class ReadyStatus extends $pb.GeneratedMessage {
  factory ReadyStatus({
    $core.bool? ready,
  }) {
    final $result = create();
    if (ready != null) {
      $result.ready = ready;
    }
    return $result;
  }
  ReadyStatus._() : super();
  factory ReadyStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReadyStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReadyStatus', package: const $pb.PackageName(_omitMessageNames ? '' : 'common.health'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'ready')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReadyStatus clone() => ReadyStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReadyStatus copyWith(void Function(ReadyStatus) updates) => super.copyWith((message) => updates(message as ReadyStatus)) as ReadyStatus;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReadyStatus create() => ReadyStatus._();
  ReadyStatus createEmptyInstance() => create();
  static $pb.PbList<ReadyStatus> createRepeated() => $pb.PbList<ReadyStatus>();
  @$core.pragma('dart2js:noInline')
  static ReadyStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReadyStatus>(create);
  static ReadyStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get ready => $_getBF(0);
  @$pb.TagNumber(1)
  set ready($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReady() => $_has(0);
  @$pb.TagNumber(1)
  void clearReady() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
