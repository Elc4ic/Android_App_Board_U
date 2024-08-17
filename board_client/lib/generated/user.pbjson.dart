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

@$core.Deprecated('Use getByUserIdRequestDescriptor instead')
const GetByUserIdRequest$json = {
  '1': 'GetByUserIdRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
  ],
};

/// Descriptor for `GetByUserIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getByUserIdRequestDescriptor = $convert.base64Decode(
    'ChJHZXRCeVVzZXJJZFJlcXVlc3QSDgoCaWQYASABKARSAmlk');

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
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'username', '3': 3, '4': 1, '5': 9, '10': 'username'},
    {'1': 'password', '3': 4, '4': 1, '5': 9, '10': 'password'},
    {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone', '3': 6, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'address', '3': 7, '4': 1, '5': 9, '10': 'address'},
    {'1': 'avatar', '3': 8, '4': 1, '5': 12, '10': 'avatar'},
    {'1': 'rating_all', '3': 9, '4': 1, '5': 5, '10': 'ratingAll'},
    {'1': 'rating_num', '3': 10, '4': 1, '5': 5, '10': 'ratingNum'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgEUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhoKCHVzZXJuYW1lGA'
    'MgASgJUgh1c2VybmFtZRIaCghwYXNzd29yZBgEIAEoCVIIcGFzc3dvcmQSFAoFZW1haWwYBSAB'
    'KAlSBWVtYWlsEhQKBXBob25lGAYgASgJUgVwaG9uZRIYCgdhZGRyZXNzGAcgASgJUgdhZGRyZX'
    'NzEhYKBmF2YXRhchgIIAEoDFIGYXZhdGFyEh0KCnJhdGluZ19hbGwYCSABKAVSCXJhdGluZ0Fs'
    'bBIdCgpyYXRpbmdfbnVtGAogASgFUglyYXRpbmdOdW0=');

@$core.Deprecated('Use commentDescriptor instead')
const Comment$json = {
  '1': 'Comment',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'rating', '3': 2, '4': 1, '5': 5, '10': 'rating'},
    {'1': 'text', '3': 3, '4': 1, '5': 9, '10': 'text'},
    {'1': 'convicted', '3': 4, '4': 1, '5': 11, '6': '.board.User', '10': 'convicted'},
    {'1': 'owner', '3': 5, '4': 1, '5': 11, '6': '.board.User', '10': 'owner'},
    {'1': 'created', '3': 6, '4': 1, '5': 9, '10': 'created'},
  ],
};

/// Descriptor for `Comment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commentDescriptor = $convert.base64Decode(
    'CgdDb21tZW50Eg4KAmlkGAEgASgDUgJpZBIWCgZyYXRpbmcYAiABKAVSBnJhdGluZxISCgR0ZX'
    'h0GAMgASgJUgR0ZXh0EikKCWNvbnZpY3RlZBgEIAEoCzILLmJvYXJkLlVzZXJSCWNvbnZpY3Rl'
    'ZBIhCgVvd25lchgFIAEoCzILLmJvYXJkLlVzZXJSBW93bmVyEhgKB2NyZWF0ZWQYBiABKAlSB2'
    'NyZWF0ZWQ=');

@$core.Deprecated('Use commentProtoDescriptor instead')
const CommentProto$json = {
  '1': 'CommentProto',
  '2': [
    {'1': 'comment', '3': 1, '4': 1, '5': 11, '6': '.board.Comment', '10': 'comment'},
    {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `CommentProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commentProtoDescriptor = $convert.base64Decode(
    'CgxDb21tZW50UHJvdG8SKAoHY29tbWVudBgBIAEoCzIOLmJvYXJkLkNvbW1lbnRSB2NvbW1lbn'
    'QSFAoFdG9rZW4YAiABKAlSBXRva2Vu');

@$core.Deprecated('Use commentsResponseDescriptor instead')
const CommentsResponse$json = {
  '1': 'CommentsResponse',
  '2': [
    {'1': 'comments', '3': 1, '4': 3, '5': 11, '6': '.board.Comment', '10': 'comments'},
  ],
};

/// Descriptor for `CommentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commentsResponseDescriptor = $convert.base64Decode(
    'ChBDb21tZW50c1Jlc3BvbnNlEioKCGNvbW1lbnRzGAEgAygLMg4uYm9hcmQuQ29tbWVudFIIY2'
    '9tbWVudHM=');

@$core.Deprecated('Use idAndJwtDescriptor instead')
const IdAndJwt$json = {
  '1': 'IdAndJwt',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `IdAndJwt`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List idAndJwtDescriptor = $convert.base64Decode(
    'CghJZEFuZEp3dBIOCgJpZBgBIAEoA1ICaWQSFAoFdG9rZW4YAiABKAlSBXRva2Vu');

