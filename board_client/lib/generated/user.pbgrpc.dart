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
  static final _$signUp = $grpc.ClientMethod<$0.SignupRequestMessage, $0.SignupResponseMessage>(
      '/board.UserAPI/SignUp',
      ($0.SignupRequestMessage value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SignupResponseMessage.fromBuffer(value));
  static final _$login = $grpc.ClientMethod<$0.LoginRequestMessage, $0.LoginResponseMessage>(
      '/board.UserAPI/Login',
      ($0.LoginRequestMessage value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.LoginResponseMessage.fromBuffer(value));
  static final _$changeUserData = $grpc.ClientMethod<$0.SetUser, $0.IsSuccess>(
      '/board.UserAPI/ChangeUserData',
      ($0.SetUser value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.IsSuccess.fromBuffer(value));
  static final _$deleteUser = $grpc.ClientMethod<$0.TokenProto, $0.IsSuccess>(
      '/board.UserAPI/DeleteUser',
      ($0.TokenProto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.IsSuccess.fromBuffer(value));

  UserAPIClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.SignupResponseMessage> signUp($0.SignupRequestMessage request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signUp, request, options: options);
  }

  $grpc.ResponseFuture<$0.LoginResponseMessage> login($0.LoginRequestMessage request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$0.IsSuccess> changeUserData($0.SetUser request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$changeUserData, request, options: options);
  }

  $grpc.ResponseFuture<$0.IsSuccess> deleteUser($0.TokenProto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteUser, request, options: options);
  }
}

@$pb.GrpcServiceName('board.UserAPI')
abstract class UserAPIServiceBase extends $grpc.Service {
  $core.String get $name => 'board.UserAPI';

  UserAPIServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SignupRequestMessage, $0.SignupResponseMessage>(
        'SignUp',
        signUp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SignupRequestMessage.fromBuffer(value),
        ($0.SignupResponseMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LoginRequestMessage, $0.LoginResponseMessage>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LoginRequestMessage.fromBuffer(value),
        ($0.LoginResponseMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetUser, $0.IsSuccess>(
        'ChangeUserData',
        changeUserData_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SetUser.fromBuffer(value),
        ($0.IsSuccess value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TokenProto, $0.IsSuccess>(
        'DeleteUser',
        deleteUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TokenProto.fromBuffer(value),
        ($0.IsSuccess value) => value.writeToBuffer()));
  }

  $async.Future<$0.SignupResponseMessage> signUp_Pre($grpc.ServiceCall call, $async.Future<$0.SignupRequestMessage> request) async {
    return signUp(call, await request);
  }

  $async.Future<$0.LoginResponseMessage> login_Pre($grpc.ServiceCall call, $async.Future<$0.LoginRequestMessage> request) async {
    return login(call, await request);
  }

  $async.Future<$0.IsSuccess> changeUserData_Pre($grpc.ServiceCall call, $async.Future<$0.SetUser> request) async {
    return changeUserData(call, await request);
  }

  $async.Future<$0.IsSuccess> deleteUser_Pre($grpc.ServiceCall call, $async.Future<$0.TokenProto> request) async {
    return deleteUser(call, await request);
  }

  $async.Future<$0.SignupResponseMessage> signUp($grpc.ServiceCall call, $0.SignupRequestMessage request);
  $async.Future<$0.LoginResponseMessage> login($grpc.ServiceCall call, $0.LoginRequestMessage request);
  $async.Future<$0.IsSuccess> changeUserData($grpc.ServiceCall call, $0.SetUser request);
  $async.Future<$0.IsSuccess> deleteUser($grpc.ServiceCall call, $0.TokenProto request);
}
