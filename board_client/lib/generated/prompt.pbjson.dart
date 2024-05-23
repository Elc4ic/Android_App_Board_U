//
//  Generated code. Do not modify.
//  source: prompt.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getManyPromptsRequestDescriptor instead')
const GetManyPromptsRequest$json = {
  '1': 'GetManyPromptsRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'token', '3': 4, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `GetManyPromptsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getManyPromptsRequestDescriptor = $convert.base64Decode(
    'ChVHZXRNYW55UHJvbXB0c1JlcXVlc3QSFAoFcXVlcnkYASABKAlSBXF1ZXJ5EhQKBXRva2VuGA'
    'QgASgJUgV0b2tlbg==');

@$core.Deprecated('Use changePromptRequestDescriptor instead')
const ChangePromptRequest$json = {
  '1': 'ChangePromptRequest',
  '2': [
    {'1': 'prompt', '3': 1, '4': 1, '5': 11, '6': '.board.Prompt', '10': 'prompt'},
    {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `ChangePromptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changePromptRequestDescriptor = $convert.base64Decode(
    'ChNDaGFuZ2VQcm9tcHRSZXF1ZXN0EiUKBnByb21wdBgBIAEoCzINLmJvYXJkLlByb21wdFIGcH'
    'JvbXB0EhQKBXRva2VuGAIgASgJUgV0b2tlbg==');

@$core.Deprecated('Use setPerformRequestDescriptor instead')
const SetPerformRequest$json = {
  '1': 'SetPerformRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `SetPerformRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPerformRequestDescriptor = $convert.base64Decode(
    'ChFTZXRQZXJmb3JtUmVxdWVzdBIOCgJpZBgBIAEoA1ICaWQSFAoFdG9rZW4YAiABKAlSBXRva2'
    'Vu');

@$core.Deprecated('Use paginatedPromptDescriptor instead')
const PaginatedPrompt$json = {
  '1': 'PaginatedPrompt',
  '2': [
    {'1': 'data', '3': 1, '4': 3, '5': 11, '6': '.board.Prompt', '10': 'data'},
    {
      '1': 'count',
      '3': 2,
      '4': 1,
      '5': 3,
      '8': {'6': 2},
      '10': 'count',
    },
    {
      '1': 'total',
      '3': 3,
      '4': 1,
      '5': 3,
      '8': {'6': 2},
      '10': 'total',
    },
    {
      '1': 'page',
      '3': 4,
      '4': 1,
      '5': 3,
      '8': {'6': 2},
      '10': 'page',
    },
    {
      '1': 'page_count',
      '3': 5,
      '4': 1,
      '5': 3,
      '8': {'6': 2},
      '10': 'pageCount',
    },
  ],
};

/// Descriptor for `PaginatedPrompt`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginatedPromptDescriptor = $convert.base64Decode(
    'Cg9QYWdpbmF0ZWRQcm9tcHQSIQoEZGF0YRgBIAMoCzINLmJvYXJkLlByb21wdFIEZGF0YRIYCg'
    'Vjb3VudBgCIAEoA0ICMAJSBWNvdW50EhgKBXRvdGFsGAMgASgDQgIwAlIFdG90YWwSFgoEcGFn'
    'ZRgEIAEoA0ICMAJSBHBhZ2USIQoKcGFnZV9jb3VudBgFIAEoA0ICMAJSCXBhZ2VDb3VudA==');

@$core.Deprecated('Use promptDescriptor instead')
const Prompt$json = {
  '1': 'Prompt',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'reward', '3': 3, '4': 1, '5': 3, '10': 'reward'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'is_active', '3': 6, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'views', '3': 7, '4': 1, '5': 5, '10': 'views'},
    {'1': 'images', '3': 8, '4': 3, '5': 9, '10': 'images'},
    {'1': 'address', '3': 9, '4': 1, '5': 9, '10': 'address'},
    {'1': 'created', '3': 10, '4': 1, '5': 9, '10': 'created'},
    {'1': 'owner', '3': 11, '4': 1, '5': 11, '6': '.board.User', '10': 'owner'},
    {'1': 'performer', '3': 12, '4': 1, '5': 11, '6': '.board.User', '10': 'performer'},
    {'1': 'category', '3': 13, '4': 1, '5': 11, '6': '.board.Category', '10': 'category'},
  ],
};

/// Descriptor for `Prompt`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List promptDescriptor = $convert.base64Decode(
    'CgZQcm9tcHQSDgoCaWQYASABKANSAmlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIWCgZyZXdhcm'
    'QYAyABKANSBnJld2FyZBIgCgtkZXNjcmlwdGlvbhgEIAEoCVILZGVzY3JpcHRpb24SGwoJaXNf'
    'YWN0aXZlGAYgASgIUghpc0FjdGl2ZRIUCgV2aWV3cxgHIAEoBVIFdmlld3MSFgoGaW1hZ2VzGA'
    'ggAygJUgZpbWFnZXMSGAoHYWRkcmVzcxgJIAEoCVIHYWRkcmVzcxIYCgdjcmVhdGVkGAogASgJ'
    'UgdjcmVhdGVkEiEKBW93bmVyGAsgASgLMgsuYm9hcmQuVXNlclIFb3duZXISKQoJcGVyZm9ybW'
    'VyGAwgASgLMgsuYm9hcmQuVXNlclIJcGVyZm9ybWVyEisKCGNhdGVnb3J5GA0gASgLMg8uYm9h'
    'cmQuQ2F0ZWdvcnlSCGNhdGVnb3J5');

