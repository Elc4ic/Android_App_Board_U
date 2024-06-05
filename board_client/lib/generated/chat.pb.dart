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

class JoinRequest extends $pb.GeneratedMessage {
  factory JoinRequest({
    $fixnum.Int64? chatId,
    $core.String? jwt,
  }) {
    final $result = create();
    if (chatId != null) {
      $result.chatId = chatId;
    }
    if (jwt != null) {
      $result.jwt = jwt;
    }
    return $result;
  }
  JoinRequest._() : super();
  factory JoinRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JoinRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JoinRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aOS(2, _omitFieldNames ? '' : 'jwt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JoinRequest clone() => JoinRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JoinRequest copyWith(void Function(JoinRequest) updates) => super.copyWith((message) => updates(message as JoinRequest)) as JoinRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JoinRequest create() => JoinRequest._();
  JoinRequest createEmptyInstance() => create();
  static $pb.PbList<JoinRequest> createRepeated() => $pb.PbList<JoinRequest>();
  @$core.pragma('dart2js:noInline')
  static JoinRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JoinRequest>(create);
  static JoinRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get jwt => $_getSZ(1);
  @$pb.TagNumber(2)
  set jwt($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasJwt() => $_has(1);
  @$pb.TagNumber(2)
  void clearJwt() => clearField(2);
}

class Message extends $pb.GeneratedMessage {
  factory Message({
    $core.String? id,
    $fixnum.Int64? sender,
    $fixnum.Int64? receiver,
    $core.String? message,
    $core.String? createdAt,
    $fixnum.Int64? chatId,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (sender != null) {
      $result.sender = sender;
    }
    if (receiver != null) {
      $result.receiver = receiver;
    }
    if (message != null) {
      $result.message = message;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (chatId != null) {
      $result.chatId = chatId;
    }
    return $result;
  }
  Message._() : super();
  factory Message.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Message', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aInt64(2, _omitFieldNames ? '' : 'sender')
    ..aInt64(3, _omitFieldNames ? '' : 'receiver')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..aOS(5, _omitFieldNames ? '' : 'createdAt')
    ..aInt64(6, _omitFieldNames ? '' : 'chatId')
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
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sender => $_getI64(1);
  @$pb.TagNumber(2)
  set sender($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSender() => $_has(1);
  @$pb.TagNumber(2)
  void clearSender() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get receiver => $_getI64(2);
  @$pb.TagNumber(3)
  set receiver($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReceiver() => $_has(2);
  @$pb.TagNumber(3)
  void clearReceiver() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get createdAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set createdAt($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get chatId => $_getI64(5);
  @$pb.TagNumber(6)
  set chatId($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasChatId() => $_has(5);
  @$pb.TagNumber(6)
  void clearChatId() => clearField(6);
}

class Chat extends $pb.GeneratedMessage {
  factory Chat({
    ChatPreview? chat,
    $core.Iterable<Message>? data,
  }) {
    final $result = create();
    if (chat != null) {
      $result.chat = chat;
    }
    if (data != null) {
      $result.data.addAll(data);
    }
    return $result;
  }
  Chat._() : super();
  factory Chat.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Chat.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Chat', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aOM<ChatPreview>(1, _omitFieldNames ? '' : 'chat', subBuilder: ChatPreview.create)
    ..pc<Message>(2, _omitFieldNames ? '' : 'data', $pb.PbFieldType.PM, subBuilder: Message.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Chat clone() => Chat()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Chat copyWith(void Function(Chat) updates) => super.copyWith((message) => updates(message as Chat)) as Chat;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Chat create() => Chat._();
  Chat createEmptyInstance() => create();
  static $pb.PbList<Chat> createRepeated() => $pb.PbList<Chat>();
  @$core.pragma('dart2js:noInline')
  static Chat getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Chat>(create);
  static Chat? _defaultInstance;

  @$pb.TagNumber(1)
  ChatPreview get chat => $_getN(0);
  @$pb.TagNumber(1)
  set chat(ChatPreview v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChat() => $_has(0);
  @$pb.TagNumber(1)
  void clearChat() => clearField(1);
  @$pb.TagNumber(1)
  ChatPreview ensureChat() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<Message> get data => $_getList(1);
}

class ChatPreview extends $pb.GeneratedMessage {
  factory ChatPreview({
    $fixnum.Int64? id,
    $0.User? target,
    $1.Ad? ad,
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
    return $result;
  }
  ChatPreview._() : super();
  factory ChatPreview.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatPreview.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatPreview', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOM<$0.User>(2, _omitFieldNames ? '' : 'target', subBuilder: $0.User.create)
    ..aOM<$1.Ad>(3, _omitFieldNames ? '' : 'ad', subBuilder: $1.Ad.create)
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
}

class SendMessageRequest extends $pb.GeneratedMessage {
  factory SendMessageRequest({
    $fixnum.Int64? receiver,
    $core.String? message,
  }) {
    final $result = create();
    if (receiver != null) {
      $result.receiver = receiver;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  SendMessageRequest._() : super();
  factory SendMessageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendMessageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendMessageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'receiver')
    ..aOS(2, _omitFieldNames ? '' : 'message')
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
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
