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

@$core.Deprecated('Use getAllMessagesRequestDescriptor instead')
const GetAllMessagesRequest$json = {
  '1': 'GetAllMessagesRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'chat_id', '3': 2, '4': 1, '5': 3, '10': 'chatId'},
  ],
};

/// Descriptor for `GetAllMessagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAllMessagesRequestDescriptor = $convert.base64Decode(
    'ChVHZXRBbGxNZXNzYWdlc1JlcXVlc3QSFAoFdG9rZW4YASABKAlSBXRva2VuEhcKB2NoYXRfaW'
    'QYAiABKANSBmNoYXRJZA==');

@$core.Deprecated('Use getAllMessagesResponseDescriptor instead')
const GetAllMessagesResponse$json = {
  '1': 'GetAllMessagesResponse',
  '2': [
    {'1': 'messages', '3': 1, '4': 3, '5': 11, '6': '.board.Message', '10': 'messages'},
    {'1': 'chat', '3': 2, '4': 1, '5': 11, '6': '.board.ChatPreview', '10': 'chat'},
  ],
};

/// Descriptor for `GetAllMessagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAllMessagesResponseDescriptor = $convert.base64Decode(
    'ChZHZXRBbGxNZXNzYWdlc1Jlc3BvbnNlEioKCG1lc3NhZ2VzGAEgAygLMg4uYm9hcmQuTWVzc2'
    'FnZVIIbWVzc2FnZXMSJgoEY2hhdBgCIAEoCzISLmJvYXJkLkNoYXRQcmV2aWV3UgRjaGF0');

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

@$core.Deprecated('Use startRequestDescriptor instead')
const StartRequest$json = {
  '1': 'StartRequest',
  '2': [
    {'1': 'ad', '3': 1, '4': 1, '5': 11, '6': '.board.Ad', '10': 'ad'},
    {'1': 'token', '3': 3, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `StartRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startRequestDescriptor = $convert.base64Decode(
    'CgxTdGFydFJlcXVlc3QSGQoCYWQYASABKAsyCS5ib2FyZC5BZFICYWQSFAoFdG9rZW4YAyABKA'
    'lSBXRva2Vu');

@$core.Deprecated('Use startResponseDescriptor instead')
const StartResponse$json = {
  '1': 'StartResponse',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
  ],
};

/// Descriptor for `StartResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startResponseDescriptor = $convert.base64Decode(
    'Cg1TdGFydFJlc3BvbnNlEhcKB2NoYXRfaWQYASABKANSBmNoYXRJZA==');

@$core.Deprecated('Use messageDescriptor instead')
const Message$json = {
  '1': 'Message',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'sender', '3': 2, '4': 1, '5': 11, '6': '.board.User', '10': 'sender'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    {'1': 'created_at', '3': 5, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode(
    'CgdNZXNzYWdlEg4KAmlkGAEgASgDUgJpZBIjCgZzZW5kZXIYAiABKAsyCy5ib2FyZC5Vc2VyUg'
    'ZzZW5kZXISGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZRIdCgpjcmVhdGVkX2F0GAUgASgJUglj'
    'cmVhdGVkQXQ=');

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
    {'1': 'chat_id', '3': 2, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'data', '3': 4, '4': 1, '5': 9, '10': 'data'},
  ],
};

/// Descriptor for `SendMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageRequestDescriptor = $convert.base64Decode(
    'ChJTZW5kTWVzc2FnZVJlcXVlc3QSGgoIcmVjZWl2ZXIYASABKANSCHJlY2VpdmVyEhcKB2NoYX'
    'RfaWQYAiABKANSBmNoYXRJZBIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlEhIKBGRhdGEYBCAB'
    'KAlSBGRhdGE=');

