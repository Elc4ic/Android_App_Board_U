//
//  Generated code. Do not modify.
//  source: user.proto
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

import 'user.pb.dart' as $0;

export 'user.pb.dart';

@$pb.GrpcServiceName('board.UserAPI')
class UserAPIClient extends $grpc.Client {
  static final _$getSignUp = $grpc.ClientMethod<$0.SignupRequest, $0.IsSuccess>(
      '/board.UserAPI/GetSignUp',
      ($0.SignupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.IsSuccess.fromBuffer(value));
  static final _$getLogin = $grpc.ClientMethod<$0.LoginRequest, $0.LoginResponse>(
      '/board.UserAPI/GetLogin',
      ($0.LoginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.LoginResponse.fromBuffer(value));
  static final _$getUserData = $grpc.ClientMethod<$0.JwtProto, $0.UserResponse>(
      '/board.UserAPI/GetUserData',
      ($0.JwtProto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UserResponse.fromBuffer(value));
  static final _$getUserById = $grpc.ClientMethod<$0.GetByUserIdRequest, $0.UserResponse>(
      '/board.UserAPI/GetUserById',
      ($0.GetByUserIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UserResponse.fromBuffer(value));
  static final _$changeUserData = $grpc.ClientMethod<$0.SetUser, $0.IsSuccess>(
      '/board.UserAPI/ChangeUserData',
      ($0.SetUser value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.IsSuccess.fromBuffer(value));
  static final _$deleteUser = $grpc.ClientMethod<$0.JwtProto, $0.IsSuccess>(
      '/board.UserAPI/DeleteUser',
      ($0.JwtProto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.IsSuccess.fromBuffer(value));

  UserAPIClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.IsSuccess> getSignUp($0.SignupRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSignUp, request, options: options);
  }

  $grpc.ResponseFuture<$0.LoginResponse> getLogin($0.LoginRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLogin, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserResponse> getUserData($0.JwtProto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserData, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserResponse> getUserById($0.GetByUserIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserById, request, options: options);
  }

  $grpc.ResponseFuture<$0.IsSuccess> changeUserData($0.SetUser request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$changeUserData, request, options: options);
  }

  $grpc.ResponseFuture<$0.IsSuccess> deleteUser($0.JwtProto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteUser, request, options: options);
  }
}

@$pb.GrpcServiceName('board.UserAPI')
abstract class UserAPIServiceBase extends $grpc.Service {
  $core.String get $name => 'board.UserAPI';

  UserAPIServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SignupRequest, $0.IsSuccess>(
        'GetSignUp',
        getSignUp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SignupRequest.fromBuffer(value),
        ($0.IsSuccess value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LoginRequest, $0.LoginResponse>(
        'GetLogin',
        getLogin_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LoginRequest.fromBuffer(value),
        ($0.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JwtProto, $0.UserResponse>(
        'GetUserData',
        getUserData_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.JwtProto.fromBuffer(value),
        ($0.UserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetByUserIdRequest, $0.UserResponse>(
        'GetUserById',
        getUserById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetByUserIdRequest.fromBuffer(value),
        ($0.UserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetUser, $0.IsSuccess>(
        'ChangeUserData',
        changeUserData_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SetUser.fromBuffer(value),
        ($0.IsSuccess value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JwtProto, $0.IsSuccess>(
        'DeleteUser',
        deleteUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.JwtProto.fromBuffer(value),
        ($0.IsSuccess value) => value.writeToBuffer()));
  }

  $async.Future<$0.IsSuccess> getSignUp_Pre($grpc.ServiceCall call, $async.Future<$0.SignupRequest> request) async {
    return getSignUp(call, await request);
  }

  $async.Future<$0.LoginResponse> getLogin_Pre($grpc.ServiceCall call, $async.Future<$0.LoginRequest> request) async {
    return getLogin(call, await request);
  }

  $async.Future<$0.UserResponse> getUserData_Pre($grpc.ServiceCall call, $async.Future<$0.JwtProto> request) async {
    return getUserData(call, await request);
  }

  $async.Future<$0.UserResponse> getUserById_Pre($grpc.ServiceCall call, $async.Future<$0.GetByUserIdRequest> request) async {
    return getUserById(call, await request);
  }

  $async.Future<$0.IsSuccess> changeUserData_Pre($grpc.ServiceCall call, $async.Future<$0.SetUser> request) async {
    return changeUserData(call, await request);
  }

  $async.Future<$0.IsSuccess> deleteUser_Pre($grpc.ServiceCall call, $async.Future<$0.JwtProto> request) async {
    return deleteUser(call, await request);
  }

  $async.Future<$0.IsSuccess> getSignUp($grpc.ServiceCall call, $0.SignupRequest request);
  $async.Future<$0.LoginResponse> getLogin($grpc.ServiceCall call, $0.LoginRequest request);
  $async.Future<$0.UserResponse> getUserData($grpc.ServiceCall call, $0.JwtProto request);
  $async.Future<$0.UserResponse> getUserById($grpc.ServiceCall call, $0.GetByUserIdRequest request);
  $async.Future<$0.IsSuccess> changeUserData($grpc.ServiceCall call, $0.SetUser request);
  $async.Future<$0.IsSuccess> deleteUser($grpc.ServiceCall call, $0.JwtProto request);
}
