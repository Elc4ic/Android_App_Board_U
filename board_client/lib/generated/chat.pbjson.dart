//
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use repeatedChatPreviewDescriptor instead')
const RepeatedChatPreview$json = {
  '1': 'RepeatedChatPreview',
  '2': [
    {'1': 'chats', '3': 1, '4': 3, '5': 11, '6': '.board.ChatPreview', '10': 'chats'},
  ],
};

/// Descriptor for `RepeatedChatPreview`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List repeatedChatPreviewDescriptor = $convert.base64Decode(
    'ChNSZXBlYXRlZENoYXRQcmV2aWV3EigKBWNoYXRzGAEgAygLMhIuYm9hcmQuQ2hhdFByZXZpZX'
    'dSBWNoYXRz');

@$core.Deprecated('Use joinRequestDescriptor instead')
const JoinRequest$json = {
  '1': 'JoinRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'jwt', '3': 2, '4': 1, '5': 9, '10': 'jwt'},
  ],
};

/// Descriptor for `JoinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinRequestDescriptor = $convert.base64Decode(
    'CgtKb2luUmVxdWVzdBIXCgdjaGF0X2lkGAEgASgDUgZjaGF0SWQSEAoDand0GAIgASgJUgNqd3'
    'Q=');

@$core.Deprecated('Use messageDescriptor instead')
const Message$json = {
  '1': 'Message',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'sender', '3': 2, '4': 1, '5': 3, '10': 'sender'},
    {'1': 'receiver', '3': 3, '4': 1, '5': 3, '10': 'receiver'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    {'1': 'created_at', '3': 5, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'chat_id', '3': 6, '4': 1, '5': 3, '10': 'chatId'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode(
    'CgdNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIWCgZzZW5kZXIYAiABKANSBnNlbmRlchIaCghyZW'
    'NlaXZlchgDIAEoA1IIcmVjZWl2ZXISGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZRIdCgpjcmVh'
    'dGVkX2F0GAUgASgJUgljcmVhdGVkQXQSFwoHY2hhdF9pZBgGIAEoA1IGY2hhdElk');

@$core.Deprecated('Use chatDescriptor instead')
const Chat$json = {
  '1': 'Chat',
  '2': [
    {'1': 'chat', '3': 1, '4': 1, '5': 11, '6': '.board.ChatPreview', '10': 'chat'},
    {'1': 'data', '3': 2, '4': 3, '5': 11, '6': '.board.Message', '10': 'data'},
  ],
};

/// Descriptor for `Chat`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatDescriptor = $convert.base64Decode(
    'CgRDaGF0EiYKBGNoYXQYASABKAsyEi5ib2FyZC5DaGF0UHJldmlld1IEY2hhdBIiCgRkYXRhGA'
    'IgAygLMg4uYm9hcmQuTWVzc2FnZVIEZGF0YQ==');

@$core.Deprecated('Use chatPreviewDescriptor instead')
const ChatPreview$json = {
  '1': 'ChatPreview',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'target', '3': 2, '4': 1, '5': 11, '6': '.board.User', '10': 'target'},
    {'1': 'ad', '3': 3, '4': 1, '5': 11, '6': '.board.Ad', '10': 'ad'},
  ],
};

/// Descriptor for `ChatPreview`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatPreviewDescriptor = $convert.base64Decode(
    'CgtDaGF0UHJldmlldxIOCgJpZBgBIAEoA1ICaWQSIwoGdGFyZ2V0GAIgASgLMgsuYm9hcmQuVX'
    'NlclIGdGFyZ2V0EhkKAmFkGAMgASgLMgkuYm9hcmQuQWRSAmFk');

@$core.Deprecated('Use sendMessageRequestDescriptor instead')
const SendMessageRequest$json = {
  '1': 'SendMessageRequest',
  '2': [
    {'1': 'receiver', '3': 1, '4': 1, '5': 3, '10': 'receiver'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SendMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageRequestDescriptor = $convert.base64Decode(
    'ChJTZW5kTWVzc2FnZVJlcXVlc3QSGgoIcmVjZWl2ZXIYASABKANSCHJlY2VpdmVyEhgKB21lc3'
    'NhZ2UYAiABKAlSB21lc3NhZ2U=');

