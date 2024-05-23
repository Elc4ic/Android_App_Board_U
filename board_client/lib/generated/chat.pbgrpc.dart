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
  static final _$sendMessage = $grpc.ClientMethod<$3.SendMessageRequest, $0.IsSuccess>(
      '/board.ChatAPI/SendMessage',
      ($3.SendMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.IsSuccess.fromBuffer(value));

  ChatAPIClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.IsSuccess> sendMessage($3.SendMessageRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMessage, request, options: options);
  }
}

@$pb.GrpcServiceName('board.ChatAPI')
abstract class ChatAPIServiceBase extends $grpc.Service {
  $core.String get $name => 'board.ChatAPI';

  ChatAPIServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.SendMessageRequest, $0.IsSuccess>(
        'SendMessage',
        sendMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.SendMessageRequest.fromBuffer(value),
        ($0.IsSuccess value) => value.writeToBuffer()));
  }

  $async.Future<$0.IsSuccess> sendMessage_Pre($grpc.ServiceCall call, $async.Future<$3.SendMessageRequest> request) async {
    return sendMessage(call, await request);
  }

  $async.Future<$0.IsSuccess> sendMessage($grpc.ServiceCall call, $3.SendMessageRequest request);
}
