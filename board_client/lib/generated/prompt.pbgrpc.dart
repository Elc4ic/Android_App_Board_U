//
//  Generated code. Do not modify.
//  source: prompt.proto
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

import 'ad.pb.dart' as $1;
import 'prompt.pb.dart' as $2;

export 'prompt.pb.dart';

@$pb.GrpcServiceName('board.PromptAPI')
class PromptAPIClient extends $grpc.Client {
  static final _$getManyPrompts = $grpc.ClientMethod<$2.GetManyPromptsRequest, $2.PaginatedPrompt>(
      '/board.PromptAPI/GetManyPrompts',
      ($2.GetManyPromptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.PaginatedPrompt.fromBuffer(value));
  static final _$getOnePrompt = $grpc.ClientMethod<$1.GetByIdRequest, $1.Ad>(
      '/board.PromptAPI/GetOnePrompt',
      ($1.GetByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Ad.fromBuffer(value));
  static final _$setFavoritePrompt = $grpc.ClientMethod<$1.GetByIdWithBoolRequest, $1.Empty>(
      '/board.PromptAPI/SetFavoritePrompt',
      ($1.GetByIdWithBoolRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$addPrompt = $grpc.ClientMethod<$2.ChangePromptRequest, $1.Empty>(
      '/board.PromptAPI/AddPrompt',
      ($2.ChangePromptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$deletePrompt = $grpc.ClientMethod<$2.ChangePromptRequest, $1.Empty>(
      '/board.PromptAPI/DeletePrompt',
      ($2.ChangePromptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$mutePrompt = $grpc.ClientMethod<$2.ChangePromptRequest, $1.Empty>(
      '/board.PromptAPI/MutePrompt',
      ($2.ChangePromptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$getPerform = $grpc.ClientMethod<$2.SetPerformRequest, $1.Empty>(
      '/board.PromptAPI/GetPerform',
      ($2.SetPerformRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  PromptAPIClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$2.PaginatedPrompt> getManyPrompts($2.GetManyPromptsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getManyPrompts, request, options: options);
  }

  $grpc.ResponseFuture<$1.Ad> getOnePrompt($1.GetByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOnePrompt, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> setFavoritePrompt($1.GetByIdWithBoolRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setFavoritePrompt, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> addPrompt($2.ChangePromptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addPrompt, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deletePrompt($2.ChangePromptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deletePrompt, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> mutePrompt($2.ChangePromptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$mutePrompt, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> getPerform($2.SetPerformRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPerform, request, options: options);
  }
}

@$pb.GrpcServiceName('board.PromptAPI')
abstract class PromptAPIServiceBase extends $grpc.Service {
  $core.String get $name => 'board.PromptAPI';

  PromptAPIServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.GetManyPromptsRequest, $2.PaginatedPrompt>(
        'GetManyPrompts',
        getManyPrompts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetManyPromptsRequest.fromBuffer(value),
        ($2.PaginatedPrompt value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetByIdRequest, $1.Ad>(
        'GetOnePrompt',
        getOnePrompt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetByIdRequest.fromBuffer(value),
        ($1.Ad value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetByIdWithBoolRequest, $1.Empty>(
        'SetFavoritePrompt',
        setFavoritePrompt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetByIdWithBoolRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ChangePromptRequest, $1.Empty>(
        'AddPrompt',
        addPrompt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ChangePromptRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ChangePromptRequest, $1.Empty>(
        'DeletePrompt',
        deletePrompt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ChangePromptRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ChangePromptRequest, $1.Empty>(
        'MutePrompt',
        mutePrompt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ChangePromptRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.SetPerformRequest, $1.Empty>(
        'GetPerform',
        getPerform_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.SetPerformRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$2.PaginatedPrompt> getManyPrompts_Pre($grpc.ServiceCall call, $async.Future<$2.GetManyPromptsRequest> request) async {
    return getManyPrompts(call, await request);
  }

  $async.Future<$1.Ad> getOnePrompt_Pre($grpc.ServiceCall call, $async.Future<$1.GetByIdRequest> request) async {
    return getOnePrompt(call, await request);
  }

  $async.Future<$1.Empty> setFavoritePrompt_Pre($grpc.ServiceCall call, $async.Future<$1.GetByIdWithBoolRequest> request) async {
    return setFavoritePrompt(call, await request);
  }

  $async.Future<$1.Empty> addPrompt_Pre($grpc.ServiceCall call, $async.Future<$2.ChangePromptRequest> request) async {
    return addPrompt(call, await request);
  }

  $async.Future<$1.Empty> deletePrompt_Pre($grpc.ServiceCall call, $async.Future<$2.ChangePromptRequest> request) async {
    return deletePrompt(call, await request);
  }

  $async.Future<$1.Empty> mutePrompt_Pre($grpc.ServiceCall call, $async.Future<$2.ChangePromptRequest> request) async {
    return mutePrompt(call, await request);
  }

  $async.Future<$1.Empty> getPerform_Pre($grpc.ServiceCall call, $async.Future<$2.SetPerformRequest> request) async {
    return getPerform(call, await request);
  }

  $async.Future<$2.PaginatedPrompt> getManyPrompts($grpc.ServiceCall call, $2.GetManyPromptsRequest request);
  $async.Future<$1.Ad> getOnePrompt($grpc.ServiceCall call, $1.GetByIdRequest request);
  $async.Future<$1.Empty> setFavoritePrompt($grpc.ServiceCall call, $1.GetByIdWithBoolRequest request);
  $async.Future<$1.Empty> addPrompt($grpc.ServiceCall call, $2.ChangePromptRequest request);
  $async.Future<$1.Empty> deletePrompt($grpc.ServiceCall call, $2.ChangePromptRequest request);
  $async.Future<$1.Empty> mutePrompt($grpc.ServiceCall call, $2.ChangePromptRequest request);
  $async.Future<$1.Empty> getPerform($grpc.ServiceCall call, $2.SetPerformRequest request);
}
