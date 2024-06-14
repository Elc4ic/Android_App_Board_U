//
//  Generated code. Do not modify.
//  source: chat.proto
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
import 'chat.pb.dart' as $3;
import 'user.pb.dart' as $0;

export 'chat.pb.dart';

@$pb.GrpcServiceName('board.ChatAPI')
class ChatAPIClient extends $grpc.Client {
  static final _$startChat = $grpc.ClientMethod<$3.StartRequest, $3.StartResponse>(
      '/board.ChatAPI/StartChat',
      ($3.StartRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.StartResponse.fromBuffer(value));
  static final _$deleteChat = $grpc.ClientMethod<$3.DeleteChatRequest, $1.Empty>(
      '/board.ChatAPI/DeleteChat',
      ($3.DeleteChatRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$getChatsPreview = $grpc.ClientMethod<$0.JwtProto, $3.RepeatedChatPreview>(
      '/board.ChatAPI/GetChatsPreview',
      ($0.JwtProto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.RepeatedChatPreview.fromBuffer(value));
  static final _$sendMessage = $grpc.ClientMethod<$3.SendMessageRequest, $3.Message>(
      '/board.ChatAPI/SendMessage',
      ($3.SendMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.Message.fromBuffer(value));
  static final _$getAllMessage = $grpc.ClientMethod<$3.GetAllMessagesRequest, $3.GetAllMessagesResponse>(
      '/board.ChatAPI/GetAllMessage',
      ($3.GetAllMessagesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.GetAllMessagesResponse.fromBuffer(value));

  ChatAPIClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$3.StartResponse> startChat($3.StartRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startChat, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteChat($3.DeleteChatRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteChat, request, options: options);
  }

  $grpc.ResponseFuture<$3.RepeatedChatPreview> getChatsPreview($0.JwtProto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getChatsPreview, request, options: options);
  }

  $grpc.ResponseStream<$3.Message> sendMessage($async.Stream<$3.SendMessageRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$sendMessage, request, options: options);
  }

  $grpc.ResponseFuture<$3.GetAllMessagesResponse> getAllMessage($3.GetAllMessagesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAllMessage, request, options: options);
  }
}

@$pb.GrpcServiceName('board.ChatAPI')
abstract class ChatAPIServiceBase extends $grpc.Service {
  $core.String get $name => 'board.ChatAPI';

  ChatAPIServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.StartRequest, $3.StartResponse>(
        'StartChat',
        startChat_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.StartRequest.fromBuffer(value),
        ($3.StartResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.DeleteChatRequest, $1.Empty>(
        'DeleteChat',
        deleteChat_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.DeleteChatRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JwtProto, $3.RepeatedChatPreview>(
        'GetChatsPreview',
        getChatsPreview_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.JwtProto.fromBuffer(value),
        ($3.RepeatedChatPreview value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.SendMessageRequest, $3.Message>(
        'SendMessage',
        sendMessage,
        true,
        true,
        ($core.List<$core.int> value) => $3.SendMessageRequest.fromBuffer(value),
        ($3.Message value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetAllMessagesRequest, $3.GetAllMessagesResponse>(
        'GetAllMessage',
        getAllMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetAllMessagesRequest.fromBuffer(value),
        ($3.GetAllMessagesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$3.StartResponse> startChat_Pre($grpc.ServiceCall call, $async.Future<$3.StartRequest> request) async {
    return startChat(call, await request);
  }

  $async.Future<$1.Empty> deleteChat_Pre($grpc.ServiceCall call, $async.Future<$3.DeleteChatRequest> request) async {
    return deleteChat(call, await request);
  }

  $async.Future<$3.RepeatedChatPreview> getChatsPreview_Pre($grpc.ServiceCall call, $async.Future<$0.JwtProto> request) async {
    return getChatsPreview(call, await request);
  }

  $async.Future<$3.GetAllMessagesResponse> getAllMessage_Pre($grpc.ServiceCall call, $async.Future<$3.GetAllMessagesRequest> request) async {
    return getAllMessage(call, await request);
  }

  $async.Future<$3.StartResponse> startChat($grpc.ServiceCall call, $3.StartRequest request);
  $async.Future<$1.Empty> deleteChat($grpc.ServiceCall call, $3.DeleteChatRequest request);
  $async.Future<$3.RepeatedChatPreview> getChatsPreview($grpc.ServiceCall call, $0.JwtProto request);
  $async.Stream<$3.Message> sendMessage($grpc.ServiceCall call, $async.Stream<$3.SendMessageRequest> request);
  $async.Future<$3.GetAllMessagesResponse> getAllMessage($grpc.ServiceCall call, $3.GetAllMessagesRequest request);
}
