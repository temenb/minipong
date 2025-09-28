//
//  Generated code. Do not modify.
//  source: profile.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common/empty.pb.dart' as $0;
import 'common/health.pb.dart' as $1;
import 'profile.pb.dart' as $3;

export 'profile.pb.dart';

@$pb.GrpcServiceName('profile.Profile')
class ProfileClient extends $grpc.Client {
  static final _$health = $grpc.ClientMethod<$0.Empty, $1.HealthReport>(
      '/profile.Profile/Health',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.HealthReport.fromBuffer(value));
  static final _$status = $grpc.ClientMethod<$0.Empty, $1.StatusInfo>(
      '/profile.Profile/Status',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.StatusInfo.fromBuffer(value));
  static final _$livez = $grpc.ClientMethod<$0.Empty, $1.LiveStatus>(
      '/profile.Profile/Livez',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.LiveStatus.fromBuffer(value));
  static final _$readyz = $grpc.ClientMethod<$0.Empty, $1.ReadyStatus>(
      '/profile.Profile/Readyz',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ReadyStatus.fromBuffer(value));
  static final _$upsert = $grpc.ClientMethod<$3.UpsertRequest, $3.ProfileObject>(
      '/profile.Profile/Upsert',
      ($3.UpsertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.ProfileObject.fromBuffer(value));
  static final _$view = $grpc.ClientMethod<$3.ViewRequest, $3.ProfileObject>(
      '/profile.Profile/View',
      ($3.ViewRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.ProfileObject.fromBuffer(value));

  ProfileClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.HealthReport> health($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$health, request, options: options);
  }

  $grpc.ResponseFuture<$1.StatusInfo> status($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$status, request, options: options);
  }

  $grpc.ResponseFuture<$1.LiveStatus> livez($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$livez, request, options: options);
  }

  $grpc.ResponseFuture<$1.ReadyStatus> readyz($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$readyz, request, options: options);
  }

  $grpc.ResponseFuture<$3.ProfileObject> upsert($3.UpsertRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$upsert, request, options: options);
  }

  $grpc.ResponseFuture<$3.ProfileObject> view($3.ViewRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$view, request, options: options);
  }
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
    $addMethod($grpc.ServiceMethod<$3.UpsertRequest, $3.ProfileObject>(
        'Upsert',
        upsert_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.UpsertRequest.fromBuffer(value),
        ($3.ProfileObject value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.ViewRequest, $3.ProfileObject>(
        'View',
        view_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.ViewRequest.fromBuffer(value),
        ($3.ProfileObject value) => value.writeToBuffer()));
  }

  $async.Future<$1.HealthReport> health_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return health(call, await request);
  }

  $async.Future<$1.StatusInfo> status_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return status(call, await request);
  }

  $async.Future<$1.LiveStatus> livez_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return livez(call, await request);
  }

  $async.Future<$1.ReadyStatus> readyz_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return readyz(call, await request);
  }

  $async.Future<$3.ProfileObject> upsert_Pre($grpc.ServiceCall call, $async.Future<$3.UpsertRequest> request) async {
    return upsert(call, await request);
  }

  $async.Future<$3.ProfileObject> view_Pre($grpc.ServiceCall call, $async.Future<$3.ViewRequest> request) async {
    return view(call, await request);
  }

  $async.Future<$1.HealthReport> health($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.StatusInfo> status($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.LiveStatus> livez($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.ReadyStatus> readyz($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$3.ProfileObject> upsert($grpc.ServiceCall call, $3.UpsertRequest request);
  $async.Future<$3.ProfileObject> view($grpc.ServiceCall call, $3.ViewRequest request);
}
