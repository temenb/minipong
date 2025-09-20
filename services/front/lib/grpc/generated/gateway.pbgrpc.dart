//
//  Generated code. Do not modify.
//  source: gateway.proto
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

import 'auth.pb.dart' as $2;
import 'common/empty.pb.dart' as $0;
import 'common/health.pb.dart' as $1;
import 'profile.pb.dart' as $3;

export 'gateway.pb.dart';

@$pb.GrpcServiceName('gateway.Gateway')
class GatewayClient extends $grpc.Client {
  static final _$health = $grpc.ClientMethod<$0.Empty, $1.HealthReport>(
      '/gateway.Gateway/Health',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.HealthReport.fromBuffer(value));
  static final _$status = $grpc.ClientMethod<$0.Empty, $1.StatusInfo>(
      '/gateway.Gateway/Status',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.StatusInfo.fromBuffer(value));
  static final _$livez = $grpc.ClientMethod<$0.Empty, $1.LiveStatus>(
      '/gateway.Gateway/Livez',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.LiveStatus.fromBuffer(value));
  static final _$readyz = $grpc.ClientMethod<$0.Empty, $1.ReadyStatus>(
      '/gateway.Gateway/Readyz',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ReadyStatus.fromBuffer(value));
  static final _$anonymousSignIn = $grpc.ClientMethod<$2.AnonymousSignInRequest, $2.AuthResponse>(
      '/gateway.Gateway/AnonymousSignIn',
      ($2.AnonymousSignInRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.AuthResponse.fromBuffer(value));
  static final _$viewProfile = $grpc.ClientMethod<$3.ViewRequest, $3.ProfileResponse>(
      '/gateway.Gateway/ViewProfile',
      ($3.ViewRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.ProfileResponse.fromBuffer(value));

  GatewayClient($grpc.ClientChannel channel,
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

  $grpc.ResponseFuture<$2.AuthResponse> anonymousSignIn($2.AnonymousSignInRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$anonymousSignIn, request, options: options);
  }

  $grpc.ResponseFuture<$3.ProfileResponse> viewProfile($3.ViewRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$viewProfile, request, options: options);
  }
}

@$pb.GrpcServiceName('gateway.Gateway')
abstract class GatewayServiceBase extends $grpc.Service {
  $core.String get $name => 'gateway.Gateway';

  GatewayServiceBase() {
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
    $addMethod($grpc.ServiceMethod<$2.AnonymousSignInRequest, $2.AuthResponse>(
        'AnonymousSignIn',
        anonymousSignIn_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.AnonymousSignInRequest.fromBuffer(value),
        ($2.AuthResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.ViewRequest, $3.ProfileResponse>(
        'ViewProfile',
        viewProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.ViewRequest.fromBuffer(value),
        ($3.ProfileResponse value) => value.writeToBuffer()));
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

  $async.Future<$2.AuthResponse> anonymousSignIn_Pre($grpc.ServiceCall call, $async.Future<$2.AnonymousSignInRequest> request) async {
    return anonymousSignIn(call, await request);
  }

  $async.Future<$3.ProfileResponse> viewProfile_Pre($grpc.ServiceCall call, $async.Future<$3.ViewRequest> request) async {
    return viewProfile(call, await request);
  }

  $async.Future<$1.HealthReport> health($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.StatusInfo> status($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.LiveStatus> livez($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.ReadyStatus> readyz($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$2.AuthResponse> anonymousSignIn($grpc.ServiceCall call, $2.AnonymousSignInRequest request);
  $async.Future<$3.ProfileResponse> viewProfile($grpc.ServiceCall call, $3.ViewRequest request);
}
