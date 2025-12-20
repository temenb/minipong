// This is a generated file - do not edit.
//
// Generated from profile.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common/empty.pb.dart' as $0;
import 'common/health.pb.dart' as $1;
import 'profile.pb.dart' as $2;

export 'profile.pb.dart';

@$pb.GrpcServiceName('profile.Profile')
class ProfileClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ProfileClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.HealthReport> health(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$health, request, options: options);
  }

  $grpc.ResponseFuture<$1.StatusInfo> status(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$status, request, options: options);
  }

  $grpc.ResponseFuture<$1.LiveStatus> livez(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$livez, request, options: options);
  }

  $grpc.ResponseFuture<$1.ReadyStatus> readyz(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$readyz, request, options: options);
  }

  $grpc.ResponseFuture<$2.ProfileObject> upsert(
    $2.UpsertRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$upsert, request, options: options);
  }

  $grpc.ResponseFuture<$2.ProfileObject> view(
    $2.ViewRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$view, request, options: options);
  }

  // method descriptors

  static final _$health = $grpc.ClientMethod<$0.Empty, $1.HealthReport>(
      '/profile.Profile/Health',
      ($0.Empty value) => value.writeToBuffer(),
      $1.HealthReport.fromBuffer);
  static final _$status = $grpc.ClientMethod<$0.Empty, $1.StatusInfo>(
      '/profile.Profile/Status',
      ($0.Empty value) => value.writeToBuffer(),
      $1.StatusInfo.fromBuffer);
  static final _$livez = $grpc.ClientMethod<$0.Empty, $1.LiveStatus>(
      '/profile.Profile/Livez',
      ($0.Empty value) => value.writeToBuffer(),
      $1.LiveStatus.fromBuffer);
  static final _$readyz = $grpc.ClientMethod<$0.Empty, $1.ReadyStatus>(
      '/profile.Profile/Readyz',
      ($0.Empty value) => value.writeToBuffer(),
      $1.ReadyStatus.fromBuffer);
  static final _$upsert =
      $grpc.ClientMethod<$2.UpsertRequest, $2.ProfileObject>(
          '/profile.Profile/Upsert',
          ($2.UpsertRequest value) => value.writeToBuffer(),
          $2.ProfileObject.fromBuffer);
  static final _$view = $grpc.ClientMethod<$2.ViewRequest, $2.ProfileObject>(
      '/profile.Profile/View',
      ($2.ViewRequest value) => value.writeToBuffer(),
      $2.ProfileObject.fromBuffer);
}

@$pb.GrpcServiceName('profile.Profile')
abstract class ProfileServiceBase extends $grpc.Service {
  $core.String get $name => 'profile.Profile';

  ProfileServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.HealthReport>(
        'Health',
        health_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.HealthReport value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.StatusInfo>(
        'Status',
        status_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.StatusInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.LiveStatus>(
        'Livez',
        livez_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.LiveStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.ReadyStatus>(
        'Readyz',
        readyz_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.ReadyStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UpsertRequest, $2.ProfileObject>(
        'Upsert',
        upsert_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.UpsertRequest.fromBuffer(value),
        ($2.ProfileObject value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ViewRequest, $2.ProfileObject>(
        'View',
        view_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ViewRequest.fromBuffer(value),
        ($2.ProfileObject value) => value.writeToBuffer()));
  }

  $async.Future<$1.HealthReport> health_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return health($call, await $request);
  }

  $async.Future<$1.HealthReport> health(
      $grpc.ServiceCall call, $0.Empty request);

  $async.Future<$1.StatusInfo> status_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return status($call, await $request);
  }

  $async.Future<$1.StatusInfo> status($grpc.ServiceCall call, $0.Empty request);

  $async.Future<$1.LiveStatus> livez_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return livez($call, await $request);
  }

  $async.Future<$1.LiveStatus> livez($grpc.ServiceCall call, $0.Empty request);

  $async.Future<$1.ReadyStatus> readyz_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return readyz($call, await $request);
  }

  $async.Future<$1.ReadyStatus> readyz(
      $grpc.ServiceCall call, $0.Empty request);

  $async.Future<$2.ProfileObject> upsert_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.UpsertRequest> $request) async {
    return upsert($call, await $request);
  }

  $async.Future<$2.ProfileObject> upsert(
      $grpc.ServiceCall call, $2.UpsertRequest request);

  $async.Future<$2.ProfileObject> view_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.ViewRequest> $request) async {
    return view($call, await $request);
  }

  $async.Future<$2.ProfileObject> view(
      $grpc.ServiceCall call, $2.ViewRequest request);
}
