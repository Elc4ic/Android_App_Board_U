//
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use isSuccessDescriptor instead')
const IsSuccess$json = {
  '1': 'IsSuccess',
  '2': [
    {'1': 'login', '3': 1, '4': 1, '5': 8, '10': 'login'},
  ],
};

/// Descriptor for `IsSuccess`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List isSuccessDescriptor = $convert.base64Decode(
    'CglJc1N1Y2Nlc3MSFAoFbG9naW4YASABKAhSBWxvZ2lu');

@$core.Deprecated('Use loginRequestMessageDescriptor instead')
const LoginRequestMessage$json = {
  '1': 'LoginRequestMessage',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `LoginRequestMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestMessageDescriptor = $convert.base64Decode(
    'ChNMb2dpblJlcXVlc3RNZXNzYWdlEhoKCHVzZXJuYW1lGAEgASgJUgh1c2VybmFtZRIaCghwYX'
    'Nzd29yZBgCIAEoCVIIcGFzc3dvcmQ=');

@$core.Deprecated('Use loginResponseMessageDescriptor instead')
const LoginResponseMessage$json = {
  '1': 'LoginResponseMessage',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.board.User', '10': 'user'},
    {'1': 'access_token', '3': 2, '4': 1, '5': 9, '10': 'accessToken'},
  ],
};

/// Descriptor for `LoginResponseMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseMessageDescriptor = $convert.base64Decode(
    'ChRMb2dpblJlc3BvbnNlTWVzc2FnZRIfCgR1c2VyGAEgASgLMgsuYm9hcmQuVXNlclIEdXNlch'
    'IhCgxhY2Nlc3NfdG9rZW4YAiABKAlSC2FjY2Vzc1Rva2Vu');

@$core.Deprecated('Use signupRequestMessageDescriptor instead')
const SignupRequestMessage$json = {
  '1': 'SignupRequestMessage',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    {'1': 'phone', '3': 3, '4': 1, '5': 9, '10': 'phone'},
  ],
};

/// Descriptor for `SignupRequestMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupRequestMessageDescriptor = $convert.base64Decode(
    'ChRTaWdudXBSZXF1ZXN0TWVzc2FnZRIaCgh1c2VybmFtZRgBIAEoCVIIdXNlcm5hbWUSGgoIcG'
    'Fzc3dvcmQYAiABKAlSCHBhc3N3b3JkEhQKBXBob25lGAMgASgJUgVwaG9uZQ==');

@$core.Deprecated('Use signupResponseMessageDescriptor instead')
const SignupResponseMessage$json = {
  '1': 'SignupResponseMessage',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.board.User', '10': 'user'},
  ],
};

/// Descriptor for `SignupResponseMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupResponseMessageDescriptor = $convert.base64Decode(
    'ChVTaWdudXBSZXNwb25zZU1lc3NhZ2USHwoEdXNlchgBIAEoCzILLmJvYXJkLlVzZXJSBHVzZX'
    'I=');

@$core.Deprecated('Use setUserDescriptor instead')
const SetUser$json = {
  '1': 'SetUser',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.board.User', '10': 'user'},
    {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `SetUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setUserDescriptor = $convert.base64Decode(
    'CgdTZXRVc2VyEh8KBHVzZXIYASABKAsyCy5ib2FyZC5Vc2VyUgR1c2VyEhQKBXRva2VuGAIgAS'
    'gJUgV0b2tlbg==');

@$core.Deprecated('Use tokenProtoDescriptor instead')
const TokenProto$json = {
  '1': 'TokenProto',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `TokenProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tokenProtoDescriptor = $convert.base64Decode(
    'CgpUb2tlblByb3RvEhQKBXRva2VuGAEgASgJUgV0b2tlbg==');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'password', '3': 3, '4': 1, '5': 9, '10': 'password'},
    {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    {'1': 'token', '3': 5, '4': 1, '5': 9, '10': 'token'},
    {'1': 'address', '3': 6, '4': 1, '5': 9, '10': 'address'},
    {'1': 'avatar', '3': 7, '4': 1, '5': 9, '10': 'avatar'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgEUgJpZBIaCgh1c2VybmFtZRgCIAEoCVIIdXNlcm5hbWUSGgoIcG'
    'Fzc3dvcmQYAyABKAlSCHBhc3N3b3JkEhQKBWVtYWlsGAQgASgJUgVlbWFpbBIUCgV0b2tlbhgF'
    'IAEoCVIFdG9rZW4SGAoHYWRkcmVzcxgGIAEoCVIHYWRkcmVzcxIWCgZhdmF0YXIYByABKAlSBm'
    'F2YXRhcg==');

