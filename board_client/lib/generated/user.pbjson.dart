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

@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = {
  '1': 'LoginRequest',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert.base64Decode(
    'CgxMb2dpblJlcXVlc3QSGgoIdXNlcm5hbWUYASABKAlSCHVzZXJuYW1lEhoKCHBhc3N3b3JkGA'
    'IgASgJUghwYXNzd29yZA==');

@$core.Deprecated('Use loginResponseDescriptor instead')
const LoginResponse$json = {
  '1': 'LoginResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.board.User', '10': 'user'},
    {'1': 'access_token', '3': 2, '4': 1, '5': 9, '10': 'accessToken'},
  ],
};

/// Descriptor for `LoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseDescriptor = $convert.base64Decode(
    'Cg1Mb2dpblJlc3BvbnNlEh8KBHVzZXIYASABKAsyCy5ib2FyZC5Vc2VyUgR1c2VyEiEKDGFjY2'
    'Vzc190b2tlbhgCIAEoCVILYWNjZXNzVG9rZW4=');

@$core.Deprecated('Use signupRequestDescriptor instead')
const SignupRequest$json = {
  '1': 'SignupRequest',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    {'1': 'phone', '3': 3, '4': 1, '5': 9, '10': 'phone'},
  ],
};

/// Descriptor for `SignupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupRequestDescriptor = $convert.base64Decode(
    'Cg1TaWdudXBSZXF1ZXN0EhoKCHVzZXJuYW1lGAEgASgJUgh1c2VybmFtZRIaCghwYXNzd29yZB'
    'gCIAEoCVIIcGFzc3dvcmQSFAoFcGhvbmUYAyABKAlSBXBob25l');

@$core.Deprecated('Use userResponseDescriptor instead')
const UserResponse$json = {
  '1': 'UserResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.board.User', '10': 'user'},
  ],
};

/// Descriptor for `UserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userResponseDescriptor = $convert.base64Decode(
    'CgxVc2VyUmVzcG9uc2USHwoEdXNlchgBIAEoCzILLmJvYXJkLlVzZXJSBHVzZXI=');

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

@$core.Deprecated('Use jwtProtoDescriptor instead')
const JwtProto$json = {
  '1': 'JwtProto',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `JwtProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jwtProtoDescriptor = $convert.base64Decode(
    'CghKd3RQcm90bxIUCgV0b2tlbhgBIAEoCVIFdG9rZW4=');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'password', '3': 3, '4': 1, '5': 9, '10': 'password'},
    {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'address', '3': 6, '4': 1, '5': 9, '10': 'address'},
    {'1': 'avatar', '3': 7, '4': 1, '5': 9, '10': 'avatar'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgEUgJpZBIaCgh1c2VybmFtZRgCIAEoCVIIdXNlcm5hbWUSGgoIcG'
    'Fzc3dvcmQYAyABKAlSCHBhc3N3b3JkEhQKBWVtYWlsGAQgASgJUgVlbWFpbBIUCgVwaG9uZRgF'
    'IAEoCVIFcGhvbmUSGAoHYWRkcmVzcxgGIAEoCVIHYWRkcmVzcxIWCgZhdmF0YXIYByABKAlSBm'
    'F2YXRhcg==');

