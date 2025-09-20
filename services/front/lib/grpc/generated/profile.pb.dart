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
    $core.String? profileId,
  }) {
    final $result = create();
    if (profileId != null) {
      $result.profileId = profileId;
    }
    return $result;
  }
  ViewRequest._() : super();
  factory ViewRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ViewRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ViewRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'profile'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'profileId')
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
  $core.String get profileId => $_getSZ(0);
  @$pb.TagNumber(1)
  set profileId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProfileId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfileId() => clearField(1);
}

class ProfileResponse extends $pb.GeneratedMessage {
  factory ProfileResponse({
    $core.String? profileId,
    $core.String? ownerId,
    $core.String? nickname,
  }) {
    final $result = create();
    if (profileId != null) {
      $result.profileId = profileId;
    }
    if (ownerId != null) {
      $result.ownerId = ownerId;
    }
    if (nickname != null) {
      $result.nickname = nickname;
    }
    return $result;
  }
  ProfileResponse._() : super();
  factory ProfileResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProfileResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProfileResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'profile'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'profileId')
    ..aOS(2, _omitFieldNames ? '' : 'ownerId')
    ..aOS(3, _omitFieldNames ? '' : 'nickname')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProfileResponse clone() => ProfileResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProfileResponse copyWith(void Function(ProfileResponse) updates) => super.copyWith((message) => updates(message as ProfileResponse)) as ProfileResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProfileResponse create() => ProfileResponse._();
  ProfileResponse createEmptyInstance() => create();
  static $pb.PbList<ProfileResponse> createRepeated() => $pb.PbList<ProfileResponse>();
  @$core.pragma('dart2js:noInline')
  static ProfileResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProfileResponse>(create);
  static ProfileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get profileId => $_getSZ(0);
  @$pb.TagNumber(1)
  set profileId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProfileId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfileId() => clearField(1);

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
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
