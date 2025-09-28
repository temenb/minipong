//
//  Generated code. Do not modify.
//  source: auth.proto
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

export 'auth.pb.dart';

@$pb.GrpcServiceName('auth.Auth')
class AuthClient extends $grpc.Client {
  static final _$health = $grpc.ClientMethod<$0.Empty, $1.HealthReport>(
      '/auth.Auth/Health',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.HealthReport.fromBuffer(value));
  static final _$status = $grpc.ClientMethod<$0.Empty, $1.StatusInfo>(
      '/auth.Auth/Status',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.StatusInfo.fromBuffer(value));
  static final _$livez = $grpc.ClientMethod<$0.Empty, $1.LiveStatus>(
      '/auth.Auth/Livez',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.LiveStatus.fromBuffer(value));
  static final _$readyz = $grpc.ClientMethod<$0.Empty, $1.ReadyStatus>(
      '/auth.Auth/Readyz',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ReadyStatus.fromBuffer(value));
  static final _$register = $grpc.ClientMethod<$2.RegisterRequest, $2.AuthObject>(
      '/auth.Auth/Register',
      ($2.RegisterRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.AuthObject.fromBuffer(value));
  static final _$login = $grpc.ClientMethod<$2.LoginRequest, $2.AuthObject>(
      '/auth.Auth/Login',
      ($2.LoginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.AuthObject.fromBuffer(value));
  static final _$logout = $grpc.ClientMethod<$2.LogoutRequest, $2.LogoutResponse>(
      '/auth.Auth/Logout',
      ($2.LogoutRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.LogoutResponse.fromBuffer(value));
  static final _$refreshTokens = $grpc.ClientMethod<$2.RefreshTokensRequest, $2.AuthObject>(
      '/auth.Auth/RefreshTokens',
      ($2.RefreshTokensRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.AuthObject.fromBuffer(value));
  static final _$forgotPassword = $grpc.ClientMethod<$2.ForgotPasswordRequest, $0.Empty>(
      '/auth.Auth/ForgotPassword',
      ($2.ForgotPasswordRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$resetPassword = $grpc.ClientMethod<$2.ResetPasswordRequest, $2.AuthObject>(
      '/auth.Auth/ResetPassword',
      ($2.ResetPasswordRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.AuthObject.fromBuffer(value));
  static final _$anonymousSignIn = $grpc.ClientMethod<$2.AnonymousSignInRequest, $2.AuthObject>(
      '/auth.Auth/AnonymousSignIn',
      ($2.AnonymousSignInRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.AuthObject.fromBuffer(value));

  AuthClient($grpc.ClientChannel channel,
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

  $grpc.ResponseFuture<$2.AuthObject> register($2.RegisterRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$register, request, options: options);
  }

  $grpc.ResponseFuture<$2.AuthObject> login($2.LoginRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$2.LogoutResponse> logout($2.LogoutRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$logout, request, options: options);
  }

  $grpc.ResponseFuture<$2.AuthObject> refreshTokens($2.RefreshTokensRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refreshTokens, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> forgotPassword($2.ForgotPasswordRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$forgotPassword, request, options: options);
  }

  $grpc.ResponseFuture<$2.AuthObject> resetPassword($2.ResetPasswordRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resetPassword, request, options: options);
  }

  $grpc.ResponseFuture<$2.AuthObject> anonymousSignIn($2.AnonymousSignInRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$anonymousSignIn, request, options: options);
  }
}

@$pb.GrpcServiceName('auth.Auth')
abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'auth.Auth';

  AuthServiceBase() {
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
    $addMethod($grpc.ServiceMethod<$2.RegisterRequest, $2.AuthObject>(
        'Register',
        register_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.RegisterRequest.fromBuffer(value),
        ($2.AuthObject value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.LoginRequest, $2.AuthObject>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.LoginRequest.fromBuffer(value),
        ($2.AuthObject value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.LogoutRequest, $2.LogoutResponse>(
        'Logout',
        logout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.LogoutRequest.fromBuffer(value),
        ($2.LogoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.RefreshTokensRequest, $2.AuthObject>(
        'RefreshTokens',
        refreshTokens_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.RefreshTokensRequest.fromBuffer(value),
        ($2.AuthObject value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ForgotPasswordRequest, $0.Empty>(
        'ForgotPassword',
        forgotPassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ForgotPasswordRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ResetPasswordRequest, $2.AuthObject>(
        'ResetPassword',
        resetPassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ResetPasswordRequest.fromBuffer(value),
        ($2.AuthObject value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.AnonymousSignInRequest, $2.AuthObject>(
        'AnonymousSignIn',
        anonymousSignIn_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.AnonymousSignInRequest.fromBuffer(value),
        ($2.AuthObject value) => value.writeToBuffer()));
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

  $async.Future<$2.AuthObject> register_Pre($grpc.ServiceCall call, $async.Future<$2.RegisterRequest> request) async {
    return register(call, await request);
  }

  $async.Future<$2.AuthObject> login_Pre($grpc.ServiceCall call, $async.Future<$2.LoginRequest> request) async {
    return login(call, await request);
  }

  $async.Future<$2.LogoutResponse> logout_Pre($grpc.ServiceCall call, $async.Future<$2.LogoutRequest> request) async {
    return logout(call, await request);
  }

  $async.Future<$2.AuthObject> refreshTokens_Pre($grpc.ServiceCall call, $async.Future<$2.RefreshTokensRequest> request) async {
    return refreshTokens(call, await request);
  }

  $async.Future<$0.Empty> forgotPassword_Pre($grpc.ServiceCall call, $async.Future<$2.ForgotPasswordRequest> request) async {
    return forgotPassword(call, await request);
  }

  $async.Future<$2.AuthObject> resetPassword_Pre($grpc.ServiceCall call, $async.Future<$2.ResetPasswordRequest> request) async {
    return resetPassword(call, await request);
  }

  $async.Future<$2.AuthObject> anonymousSignIn_Pre($grpc.ServiceCall call, $async.Future<$2.AnonymousSignInRequest> request) async {
    return anonymousSignIn(call, await request);
  }

  $async.Future<$1.HealthReport> health($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.StatusInfo> status($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.LiveStatus> livez($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.ReadyStatus> readyz($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$2.AuthObject> register($grpc.ServiceCall call, $2.RegisterRequest request);
  $async.Future<$2.AuthObject> login($grpc.ServiceCall call, $2.LoginRequest request);
  $async.Future<$2.LogoutResponse> logout($grpc.ServiceCall call, $2.LogoutRequest request);
  $async.Future<$2.AuthObject> refreshTokens($grpc.ServiceCall call, $2.RefreshTokensRequest request);
  $async.Future<$0.Empty> forgotPassword($grpc.ServiceCall call, $2.ForgotPasswordRequest request);
  $async.Future<$2.AuthObject> resetPassword($grpc.ServiceCall call, $2.ResetPasswordRequest request);
  $async.Future<$2.AuthObject> anonymousSignIn($grpc.ServiceCall call, $2.AnonymousSignInRequest request);
}
