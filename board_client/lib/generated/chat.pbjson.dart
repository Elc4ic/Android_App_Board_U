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

@$core.Deprecated('Use sendMessageRequestDescriptor instead')
const SendMessageRequest$json = {
  '1': 'SendMessageRequest',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 11, '6': '.board.Message', '10': 'message'},
  ],
};

/// Descriptor for `SendMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageRequestDescriptor = $convert.base64Decode(
    'ChJTZW5kTWVzc2FnZVJlcXVlc3QSKAoHbWVzc2FnZRgBIAEoCzIOLmJvYXJkLk1lc3NhZ2VSB2'
    '1lc3NhZ2U=');

@$core.Deprecated('Use chatDescriptor instead')
const Chat$json = {
  '1': 'Chat',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'data', '3': 2, '4': 3, '5': 11, '6': '.board.Message', '10': 'data'},
  ],
};

/// Descriptor for `Chat`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatDescriptor = $convert.base64Decode(
    'CgRDaGF0Eg4KAmlkGAEgASgDUgJpZBIiCgRkYXRhGAIgAygLMg4uYm9hcmQuTWVzc2FnZVIEZG'
    'F0YQ==');

@$core.Deprecated('Use messageDescriptor instead')
const Message$json = {
  '1': 'Message',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    {'1': 'owner', '3': 2, '4': 1, '5': 3, '10': 'owner'},
    {'1': 'receiver', '3': 3, '4': 1, '5': 3, '10': 'receiver'},
    {'1': 'token', '3': 4, '4': 1, '5': 9, '10': 'token'},
    {'1': 'data', '3': 5, '4': 1, '5': 9, '10': 'data'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode(
    'CgdNZXNzYWdlEhIKBHRleHQYASABKAlSBHRleHQSFAoFb3duZXIYAiABKANSBW93bmVyEhoKCH'
    'JlY2VpdmVyGAMgASgDUghyZWNlaXZlchIUCgV0b2tlbhgEIAEoCVIFdG9rZW4SEgoEZGF0YRgF'
    'IAEoCVIEZGF0YQ==');

