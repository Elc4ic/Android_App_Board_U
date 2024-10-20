//
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'ad.pb.dart' as $1;
import 'user.pb.dart' as $0;

class GetAllMessagesRequest extends $pb.GeneratedMessage {
  factory GetAllMessagesRequest({
    $core.String? token,
    $fixnum.Int64? chatId,
  }) {
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    if (chatId != null) {
      $result.chatId = chatId;
    }
    return $result;
  }
  GetAllMessagesRequest._() : super();
  factory GetAllMessagesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAllMessagesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAllMessagesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aInt64(2, _omitFieldNames ? '' : 'chatId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAllMessagesRequest clone() => GetAllMessagesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAllMessagesRequest copyWith(void Function(GetAllMessagesRequest) updates) => super.copyWith((message) => updates(message as GetAllMessagesRequest)) as GetAllMessagesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAllMessagesRequest create() => GetAllMessagesRequest._();
  GetAllMessagesRequest createEmptyInstance() => create();
  static $pb.PbList<GetAllMessagesRequest> createRepeated() => $pb.PbList<GetAllMessagesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAllMessagesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAllMessagesRequest>(create);
  static GetAllMessagesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get chatId => $_getI64(1);
  @$pb.TagNumber(2)
  set chatId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChatId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChatId() => clearField(2);
}

class DeleteChatRequest extends $pb.GeneratedMessage {
  factory DeleteChatRequest({
    $core.String? token,
    $fixnum.Int64? chatId,
  }) {
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    if (chatId != null) {
      $result.chatId = chatId;
    }
    return $result;
  }
  DeleteChatRequest._() : super();
  factory DeleteChatRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteChatRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteChatRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aInt64(2, _omitFieldNames ? '' : 'chatId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteChatRequest clone() => DeleteChatRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteChatRequest copyWith(void Function(DeleteChatRequest) updates) => super.copyWith((message) => updates(message as DeleteChatRequest)) as DeleteChatRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteChatRequest create() => DeleteChatRequest._();
  DeleteChatRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteChatRequest> createRepeated() => $pb.PbList<DeleteChatRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteChatRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteChatRequest>(create);
  static DeleteChatRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get chatId => $_getI64(1);
  @$pb.TagNumber(2)
  set chatId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChatId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChatId() => clearField(2);
}

class GetAllMessagesResponse extends $pb.GeneratedMessage {
  factory GetAllMessagesResponse({
    $core.Iterable<Message>? messages,
    ChatPreview? chat,
  }) {
    final $result = create();
    if (messages != null) {
      $result.messages.addAll(messages);
    }
    if (chat != null) {
      $result.chat = chat;
    }
    return $result;
  }
  GetAllMessagesResponse._() : super();
  factory GetAllMessagesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAllMessagesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAllMessagesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..pc<Message>(1, _omitFieldNames ? '' : 'messages', $pb.PbFieldType.PM, subBuilder: Message.create)
    ..aOM<ChatPreview>(2, _omitFieldNames ? '' : 'chat', subBuilder: ChatPreview.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAllMessagesResponse clone() => GetAllMessagesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAllMessagesResponse copyWith(void Function(GetAllMessagesResponse) updates) => super.copyWith((message) => updates(message as GetAllMessagesResponse)) as GetAllMessagesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAllMessagesResponse create() => GetAllMessagesResponse._();
  GetAllMessagesResponse createEmptyInstance() => create();
  static $pb.PbList<GetAllMessagesResponse> createRepeated() => $pb.PbList<GetAllMessagesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAllMessagesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAllMessagesResponse>(create);
  static GetAllMessagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Message> get messages => $_getList(0);

  @$pb.TagNumber(2)
  ChatPreview get chat => $_getN(1);
  @$pb.TagNumber(2)
  set chat(ChatPreview v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasChat() => $_has(1);
  @$pb.TagNumber(2)
  void clearChat() => clearField(2);
  @$pb.TagNumber(2)
  ChatPreview ensureChat() => $_ensure(1);
}

class RepeatedChatPreview extends $pb.GeneratedMessage {
  factory RepeatedChatPreview({
    $core.Iterable<ChatPreview>? chats,
  }) {
    final $result = create();
    if (chats != null) {
      $result.chats.addAll(chats);
    }
    return $result;
  }
  RepeatedChatPreview._() : super();
  factory RepeatedChatPreview.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RepeatedChatPreview.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RepeatedChatPreview', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..pc<ChatPreview>(1, _omitFieldNames ? '' : 'chats', $pb.PbFieldType.PM, subBuilder: ChatPreview.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RepeatedChatPreview clone() => RepeatedChatPreview()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RepeatedChatPreview copyWith(void Function(RepeatedChatPreview) updates) => super.copyWith((message) => updates(message as RepeatedChatPreview)) as RepeatedChatPreview;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RepeatedChatPreview create() => RepeatedChatPreview._();
  RepeatedChatPreview createEmptyInstance() => create();
  static $pb.PbList<RepeatedChatPreview> createRepeated() => $pb.PbList<RepeatedChatPreview>();
  @$core.pragma('dart2js:noInline')
  static RepeatedChatPreview getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RepeatedChatPreview>(create);
  static RepeatedChatPreview? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ChatPreview> get chats => $_getList(0);
}

class StartRequest extends $pb.GeneratedMessage {
  factory StartRequest({
    $1.Ad? ad,
    $core.String? token,
  }) {
    final $result = create();
    if (ad != null) {
      $result.ad = ad;
    }
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  StartRequest._() : super();
  factory StartRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StartRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aOM<$1.Ad>(1, _omitFieldNames ? '' : 'ad', subBuilder: $1.Ad.create)
    ..aOS(3, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StartRequest clone() => StartRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StartRequest copyWith(void Function(StartRequest) updates) => super.copyWith((message) => updates(message as StartRequest)) as StartRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartRequest create() => StartRequest._();
  StartRequest createEmptyInstance() => create();
  static $pb.PbList<StartRequest> createRepeated() => $pb.PbList<StartRequest>();
  @$core.pragma('dart2js:noInline')
  static StartRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StartRequest>(create);
  static StartRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Ad get ad => $_getN(0);
  @$pb.TagNumber(1)
  set ad($1.Ad v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAd() => $_has(0);
  @$pb.TagNumber(1)
  void clearAd() => clearField(1);
  @$pb.TagNumber(1)
  $1.Ad ensureAd() => $_ensure(0);

  @$pb.TagNumber(3)
  $core.String get token => $_getSZ(1);
  @$pb.TagNumber(3)
  set token($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasToken() => $_has(1);
  @$pb.TagNumber(3)
  void clearToken() => clearField(3);
}

class StartResponse extends $pb.GeneratedMessage {
  factory StartResponse({
    $fixnum.Int64? chatId,
  }) {
    final $result = create();
    if (chatId != null) {
      $result.chatId = chatId;
    }
    return $result;
  }
  StartResponse._() : super();
  factory StartResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StartResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StartResponse clone() => StartResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StartResponse copyWith(void Function(StartResponse) updates) => super.copyWith((message) => updates(message as StartResponse)) as StartResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartResponse create() => StartResponse._();
  StartResponse createEmptyInstance() => create();
  static $pb.PbList<StartResponse> createRepeated() => $pb.PbList<StartResponse>();
  @$core.pragma('dart2js:noInline')
  static StartResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StartResponse>(create);
  static StartResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => clearField(1);
}

class Message extends $pb.GeneratedMessage {
  factory Message({
    $fixnum.Int64? id,
    $0.User? sender,
    $core.String? message,
    $core.String? createdAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (sender != null) {
      $result.sender = sender;
    }
    if (message != null) {
      $result.message = message;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  Message._() : super();
  factory Message.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Message', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOM<$0.User>(2, _omitFieldNames ? '' : 'sender', subBuilder: $0.User.create)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..aOS(5, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Message clone() => Message()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Message copyWith(void Function(Message) updates) => super.copyWith((message) => updates(message as Message)) as Message;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Message create() => Message._();
  Message createEmptyInstance() => create();
  static $pb.PbList<Message> createRepeated() => $pb.PbList<Message>();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message>(create);
  static Message? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $0.User get sender => $_getN(1);
  @$pb.TagNumber(2)
  set sender($0.User v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSender() => $_has(1);
  @$pb.TagNumber(2)
  void clearSender() => clearField(2);
  @$pb.TagNumber(2)
  $0.User ensureSender() => $_ensure(1);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get createdAt => $_getSZ(3);
  @$pb.TagNumber(5)
  set createdAt($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(5)
  void clearCreatedAt() => clearField(5);
}

class ChatPreview extends $pb.GeneratedMessage {
  factory ChatPreview({
    $fixnum.Int64? id,
    $0.User? target,
    $1.Ad? ad,
    Message? lastMessage,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (target != null) {
      $result.target = target;
    }
    if (ad != null) {
      $result.ad = ad;
    }
    if (lastMessage != null) {
      $result.lastMessage = lastMessage;
    }
    return $result;
  }
  ChatPreview._() : super();
  factory ChatPreview.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatPreview.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatPreview', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOM<$0.User>(2, _omitFieldNames ? '' : 'target', subBuilder: $0.User.create)
    ..aOM<$1.Ad>(3, _omitFieldNames ? '' : 'ad', subBuilder: $1.Ad.create)
    ..aOM<Message>(4, _omitFieldNames ? '' : 'lastMessage', subBuilder: Message.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatPreview clone() => ChatPreview()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatPreview copyWith(void Function(ChatPreview) updates) => super.copyWith((message) => updates(message as ChatPreview)) as ChatPreview;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatPreview create() => ChatPreview._();
  ChatPreview createEmptyInstance() => create();
  static $pb.PbList<ChatPreview> createRepeated() => $pb.PbList<ChatPreview>();
  @$core.pragma('dart2js:noInline')
  static ChatPreview getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatPreview>(create);
  static ChatPreview? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $0.User get target => $_getN(1);
  @$pb.TagNumber(2)
  set target($0.User v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTarget() => $_has(1);
  @$pb.TagNumber(2)
  void clearTarget() => clearField(2);
  @$pb.TagNumber(2)
  $0.User ensureTarget() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.Ad get ad => $_getN(2);
  @$pb.TagNumber(3)
  set ad($1.Ad v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasAd() => $_has(2);
  @$pb.TagNumber(3)
  void clearAd() => clearField(3);
  @$pb.TagNumber(3)
  $1.Ad ensureAd() => $_ensure(2);

  @$pb.TagNumber(4)
  Message get lastMessage => $_getN(3);
  @$pb.TagNumber(4)
  set lastMessage(Message v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasLastMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastMessage() => clearField(4);
  @$pb.TagNumber(4)
  Message ensureLastMessage() => $_ensure(3);
}

class SendMessageRequest extends $pb.GeneratedMessage {
  factory SendMessageRequest({
    $fixnum.Int64? receiver,
    $fixnum.Int64? chatId,
    $core.String? message,
    $core.String? data,
  }) {
    final $result = create();
    if (receiver != null) {
      $result.receiver = receiver;
    }
    if (chatId != null) {
      $result.chatId = chatId;
    }
    if (message != null) {
      $result.message = message;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  SendMessageRequest._() : super();
  factory SendMessageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendMessageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendMessageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'receiver')
    ..aInt64(2, _omitFieldNames ? '' : 'chatId')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aOS(4, _omitFieldNames ? '' : 'data')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendMessageRequest clone() => SendMessageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendMessageRequest copyWith(void Function(SendMessageRequest) updates) => super.copyWith((message) => updates(message as SendMessageRequest)) as SendMessageRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendMessageRequest create() => SendMessageRequest._();
  SendMessageRequest createEmptyInstance() => create();
  static $pb.PbList<SendMessageRequest> createRepeated() => $pb.PbList<SendMessageRequest>();
  @$core.pragma('dart2js:noInline')
  static SendMessageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendMessageRequest>(create);
  static SendMessageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get receiver => $_getI64(0);
  @$pb.TagNumber(1)
  set receiver($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReceiver() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiver() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get chatId => $_getI64(1);
  @$pb.TagNumber(2)
  set chatId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChatId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChatId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get data => $_getSZ(3);
  @$pb.TagNumber(4)
  set data($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasData() => $_has(3);
  @$pb.TagNumber(4)
  void clearData() => clearField(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
