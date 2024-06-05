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

import 'chat.pb.dart' as $3;
import 'user.pb.dart' as $0;

export 'chat.pb.dart';

@$pb.GrpcServiceName('board.ChatAPI')
class ChatAPIClient extends $grpc.Client {
  static final _$getChatsPreview = $grpc.ClientMethod<$0.JwtProto, $3.RepeatedChatPreview>(
      '/board.ChatAPI/GetChatsPreview',
      ($0.JwtProto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.RepeatedChatPreview.fromBuffer(value));
  static final _$joinChat = $grpc.ClientMethod<$3.JoinRequest, $3.Chat>(
      '/board.ChatAPI/JoinChat',
      ($3.JoinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.Chat.fromBuffer(value));
  static final _$sendMessage = $grpc.ClientMethod<$3.SendMessageRequest, $3.Message>(
      '/board.ChatAPI/SendMessage',
      ($3.SendMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.Message.fromBuffer(value));

  ChatAPIClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$3.RepeatedChatPreview> getChatsPreview($0.JwtProto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getChatsPreview, request, options: options);
  }

  $grpc.ResponseFuture<$3.Chat> joinChat($3.JoinRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$joinChat, request, options: options);
  }

  $grpc.ResponseStream<$3.Message> sendMessage($async.Stream<$3.SendMessageRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$sendMessage, request, options: options);
  }
}

@$pb.GrpcServiceName('board.ChatAPI')
abstract class ChatAPIServiceBase extends $grpc.Service {
  $core.String get $name => 'board.ChatAPI';

  ChatAPIServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.JwtProto, $3.RepeatedChatPreview>(
        'GetChatsPreview',
        getChatsPreview_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.JwtProto.fromBuffer(value),
        ($3.RepeatedChatPreview value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.JoinRequest, $3.Chat>(
        'JoinChat',
        joinChat_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.JoinRequest.fromBuffer(value),
        ($3.Chat value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.SendMessageRequest, $3.Message>(
        'SendMessage',
        sendMessage,
        true,
        true,
        ($core.List<$core.int> value) => $3.SendMessageRequest.fromBuffer(value),
        ($3.Message value) => value.writeToBuffer()));
  }

  $async.Future<$3.RepeatedChatPreview> getChatsPreview_Pre($grpc.ServiceCall call, $async.Future<$0.JwtProto> request) async {
    return getChatsPreview(call, await request);
  }

  $async.Future<$3.Chat> joinChat_Pre($grpc.ServiceCall call, $async.Future<$3.JoinRequest> request) async {
    return joinChat(call, await request);
  }

  $async.Future<$3.RepeatedChatPreview> getChatsPreview($grpc.ServiceCall call, $0.JwtProto request);
  $async.Future<$3.Chat> joinChat($grpc.ServiceCall call, $3.JoinRequest request);
  $async.Stream<$3.Message> sendMessage($grpc.ServiceCall call, $async.Stream<$3.SendMessageRequest> request);
}
