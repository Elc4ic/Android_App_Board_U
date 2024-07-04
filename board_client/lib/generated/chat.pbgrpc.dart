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
import 'chat.pb.dart' as $2;
import 'user.pb.dart' as $0;

export 'chat.pb.dart';

@$pb.GrpcServiceName('board.ChatAPI')
class ChatAPIClient extends $grpc.Client {
  static final _$startChat = $grpc.ClientMethod<$2.StartRequest, $2.StartResponse>(
      '/board.ChatAPI/StartChat',
      ($2.StartRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.StartResponse.fromBuffer(value));
  static final _$deleteChat = $grpc.ClientMethod<$2.DeleteChatRequest, $1.Empty>(
      '/board.ChatAPI/DeleteChat',
      ($2.DeleteChatRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$getChatsPreview = $grpc.ClientMethod<$0.JwtProto, $2.RepeatedChatPreview>(
      '/board.ChatAPI/GetChatsPreview',
      ($0.JwtProto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.RepeatedChatPreview.fromBuffer(value));
  static final _$sendMessage = $grpc.ClientMethod<$2.SendMessageRequest, $2.Message>(
      '/board.ChatAPI/SendMessage',
      ($2.SendMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.Message.fromBuffer(value));
  static final _$getAllMessage = $grpc.ClientMethod<$2.GetAllMessagesRequest, $2.GetAllMessagesResponse>(
      '/board.ChatAPI/GetAllMessage',
      ($2.GetAllMessagesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetAllMessagesResponse.fromBuffer(value));

  ChatAPIClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$2.StartResponse> startChat($2.StartRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startChat, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteChat($2.DeleteChatRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteChat, request, options: options);
  }

  $grpc.ResponseFuture<$2.RepeatedChatPreview> getChatsPreview($0.JwtProto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getChatsPreview, request, options: options);
  }

  $grpc.ResponseStream<$2.Message> sendMessage($async.Stream<$2.SendMessageRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$sendMessage, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetAllMessagesResponse> getAllMessage($2.GetAllMessagesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAllMessage, request, options: options);
  }
}

@$pb.GrpcServiceName('board.ChatAPI')
abstract class ChatAPIServiceBase extends $grpc.Service {
  $core.String get $name => 'board.ChatAPI';

  ChatAPIServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.StartRequest, $2.StartResponse>(
        'StartChat',
        startChat_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.StartRequest.fromBuffer(value),
        ($2.StartResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeleteChatRequest, $1.Empty>(
        'DeleteChat',
        deleteChat_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.DeleteChatRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JwtProto, $2.RepeatedChatPreview>(
        'GetChatsPreview',
        getChatsPreview_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.JwtProto.fromBuffer(value),
        ($2.RepeatedChatPreview value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.SendMessageRequest, $2.Message>(
        'SendMessage',
        sendMessage,
        true,
        true,
        ($core.List<$core.int> value) => $2.SendMessageRequest.fromBuffer(value),
        ($2.Message value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetAllMessagesRequest, $2.GetAllMessagesResponse>(
        'GetAllMessage',
        getAllMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetAllMessagesRequest.fromBuffer(value),
        ($2.GetAllMessagesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.StartResponse> startChat_Pre($grpc.ServiceCall call, $async.Future<$2.StartRequest> request) async {
    return startChat(call, await request);
  }

  $async.Future<$1.Empty> deleteChat_Pre($grpc.ServiceCall call, $async.Future<$2.DeleteChatRequest> request) async {
    return deleteChat(call, await request);
  }

  $async.Future<$2.RepeatedChatPreview> getChatsPreview_Pre($grpc.ServiceCall call, $async.Future<$0.JwtProto> request) async {
    return getChatsPreview(call, await request);
  }

  $async.Future<$2.GetAllMessagesResponse> getAllMessage_Pre($grpc.ServiceCall call, $async.Future<$2.GetAllMessagesRequest> request) async {
    return getAllMessage(call, await request);
  }

  $async.Future<$2.StartResponse> startChat($grpc.ServiceCall call, $2.StartRequest request);
  $async.Future<$1.Empty> deleteChat($grpc.ServiceCall call, $2.DeleteChatRequest request);
  $async.Future<$2.RepeatedChatPreview> getChatsPreview($grpc.ServiceCall call, $0.JwtProto request);
  $async.Stream<$2.Message> sendMessage($grpc.ServiceCall call, $async.Stream<$2.SendMessageRequest> request);
  $async.Future<$2.GetAllMessagesResponse> getAllMessage($grpc.ServiceCall call, $2.GetAllMessagesRequest request);
}
