//
//  Generated code. Do not modify.
//  source: profile.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class UpsertRequest extends $pb.GeneratedMessage {
  factory UpsertRequest({
    $core.String? ownerId,
  }) {
    final $result = create();
    if (ownerId != null) {
      $result.ownerId = ownerId;
    }
    return $result;
  }
  UpsertRequest._() : super();
  factory UpsertRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpsertRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpsertRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'profile'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpsertRequest clone() => UpsertRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpsertRequest copyWith(void Function(UpsertRequest) updates) => super.copyWith((message) => updates(message as UpsertRequest)) as UpsertRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpsertRequest create() => UpsertRequest._();
  UpsertRequest createEmptyInstance() => create();
  static $pb.PbList<UpsertRequest> createRepeated() => $pb.PbList<UpsertRequest>();
  @$core.pragma('dart2js:noInline')
  static UpsertRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpsertRequest>(create);
  static UpsertRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ownerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ownerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOwnerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerId() => clearField(1);
}

class ViewRequest extends $pb.GeneratedMessage {
  factory ViewRequest({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  ViewRequest._() : super();
  factory ViewRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ViewRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ViewRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'profile'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ViewRequest clone() => ViewRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ViewRequest copyWith(void Function(ViewRequest) updates) => super.copyWith((message) => updates(message as ViewRequest)) as ViewRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ViewRequest create() => ViewRequest._();
  ViewRequest createEmptyInstance() => create();
  static $pb.PbList<ViewRequest> createRepeated() => $pb.PbList<ViewRequest>();
  @$core.pragma('dart2js:noInline')
  static ViewRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ViewRequest>(create);
  static ViewRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class ProfileObject extends $pb.GeneratedMessage {
  factory ProfileObject({
    $core.String? id,
    $core.String? ownerId,
    $core.String? nickname,
    $fixnum.Int64? level,
    $fixnum.Int64? rating,
    $fixnum.Int64? experience,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (ownerId != null) {
      $result.ownerId = ownerId;
    }
    if (nickname != null) {
      $result.nickname = nickname;
    }
    if (level != null) {
      $result.level = level;
    }
    if (rating != null) {
      $result.rating = rating;
    }
    if (experience != null) {
      $result.experience = experience;
    }
    return $result;
  }
  ProfileObject._() : super();
  factory ProfileObject.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProfileObject.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProfileObject', package: const $pb.PackageName(_omitMessageNames ? '' : 'profile'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'ownerId')
    ..aOS(3, _omitFieldNames ? '' : 'nickname')
    ..aInt64(4, _omitFieldNames ? '' : 'level')
    ..aInt64(5, _omitFieldNames ? '' : 'rating')
    ..aInt64(6, _omitFieldNames ? '' : 'experience')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProfileObject clone() => ProfileObject()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProfileObject copyWith(void Function(ProfileObject) updates) => super.copyWith((message) => updates(message as ProfileObject)) as ProfileObject;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProfileObject create() => ProfileObject._();
  ProfileObject createEmptyInstance() => create();
  static $pb.PbList<ProfileObject> createRepeated() => $pb.PbList<ProfileObject>();
  @$core.pragma('dart2js:noInline')
  static ProfileObject getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProfileObject>(create);
  static ProfileObject? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get ownerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set ownerId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOwnerId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOwnerId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get nickname => $_getSZ(2);
  @$pb.TagNumber(3)
  set nickname($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNickname() => $_has(2);
  @$pb.TagNumber(3)
  void clearNickname() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get level => $_getI64(3);
  @$pb.TagNumber(4)
  set level($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLevel() => $_has(3);
  @$pb.TagNumber(4)
  void clearLevel() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get rating => $_getI64(4);
  @$pb.TagNumber(5)
  set rating($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRating() => $_has(4);
  @$pb.TagNumber(5)
  void clearRating() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get experience => $_getI64(5);
  @$pb.TagNumber(6)
  set experience($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasExperience() => $_has(5);
  @$pb.TagNumber(6)
  void clearExperience() => clearField(6);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
