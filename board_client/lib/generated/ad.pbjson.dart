//
//  Generated code. Do not modify.
//  source: ad.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode(
    'CgVFbXB0eQ==');

@$core.Deprecated('Use getManyAdRequestDescriptor instead')
const GetManyAdRequest$json = {
  '1': 'GetManyAdRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {
      '1': 'limit',
      '3': 2,
      '4': 1,
      '5': 3,
      '8': {'6': 2},
      '10': 'limit',
    },
    {
      '1': 'page',
      '3': 3,
      '4': 1,
      '5': 3,
      '8': {'6': 2},
      '10': 'page',
    },
    {'1': 'token', '3': 4, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `GetManyAdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getManyAdRequestDescriptor = $convert.base64Decode(
    'ChBHZXRNYW55QWRSZXF1ZXN0EhQKBXF1ZXJ5GAEgASgJUgVxdWVyeRIYCgVsaW1pdBgCIAEoA0'
    'ICMAJSBWxpbWl0EhYKBHBhZ2UYAyABKANCAjACUgRwYWdlEhQKBXRva2VuGAQgASgJUgV0b2tl'
    'bg==');

@$core.Deprecated('Use getByIdRequestDescriptor instead')
const GetByIdRequest$json = {
  '1': 'GetByIdRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `GetByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getByIdRequestDescriptor = $convert.base64Decode(
    'Cg5HZXRCeUlkUmVxdWVzdBIOCgJpZBgBIAEoA1ICaWQSFAoFdG9rZW4YAiABKAlSBXRva2Vu');

@$core.Deprecated('Use changeAdRequestDescriptor instead')
const ChangeAdRequest$json = {
  '1': 'ChangeAdRequest',
  '2': [
    {'1': 'ad', '3': 1, '4': 1, '5': 11, '6': '.board.Ad', '10': 'ad'},
    {'1': 'images', '3': 2, '4': 3, '5': 11, '6': '.board.ImageProto', '10': 'images'},
    {'1': 'token', '3': 3, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `ChangeAdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changeAdRequestDescriptor = $convert.base64Decode(
    'Cg9DaGFuZ2VBZFJlcXVlc3QSGQoCYWQYASABKAsyCS5ib2FyZC5BZFICYWQSKQoGaW1hZ2VzGA'
    'IgAygLMhEuYm9hcmQuSW1hZ2VQcm90b1IGaW1hZ2VzEhQKBXRva2VuGAMgASgJUgV0b2tlbg==');

@$core.Deprecated('Use getByIdWithBoolRequestDescriptor instead')
const GetByIdWithBoolRequest$json = {
  '1': 'GetByIdWithBoolRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
    {'1': 'value', '3': 3, '4': 1, '5': 8, '10': 'value'},
  ],
};

/// Descriptor for `GetByIdWithBoolRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getByIdWithBoolRequestDescriptor = $convert.base64Decode(
    'ChZHZXRCeUlkV2l0aEJvb2xSZXF1ZXN0Eg4KAmlkGAEgASgDUgJpZBIUCgV0b2tlbhgCIAEoCV'
    'IFdG9rZW4SFAoFdmFsdWUYAyABKAhSBXZhbHVl');

@$core.Deprecated('Use paginatedAdDescriptor instead')
const PaginatedAd$json = {
  '1': 'PaginatedAd',
  '2': [
    {'1': 'data', '3': 1, '4': 3, '5': 11, '6': '.board.Ad', '10': 'data'},
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

/// Descriptor for `PaginatedAd`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginatedAdDescriptor = $convert.base64Decode(
    'CgtQYWdpbmF0ZWRBZBIdCgRkYXRhGAEgAygLMgkuYm9hcmQuQWRSBGRhdGESGAoFY291bnQYAi'
    'ABKANCAjACUgVjb3VudBIYCgV0b3RhbBgDIAEoA0ICMAJSBXRvdGFsEhYKBHBhZ2UYBCABKANC'
    'AjACUgRwYWdlEiEKCnBhZ2VfY291bnQYBSABKANCAjACUglwYWdlQ291bnQ=');

@$core.Deprecated('Use adDescriptor instead')
const Ad$json = {
  '1': 'Ad',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'price', '3': 3, '4': 1, '5': 3, '10': 'price'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'is_fav', '3': 5, '4': 1, '5': 8, '10': 'isFav'},
    {'1': 'is_active', '3': 6, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'views', '3': 7, '4': 1, '5': 5, '10': 'views'},
    {'1': 'created', '3': 10, '4': 1, '5': 9, '10': 'created'},
    {'1': 'user', '3': 11, '4': 1, '5': 11, '6': '.board.User', '10': 'user'},
    {'1': 'category', '3': 12, '4': 1, '5': 11, '6': '.board.Category', '10': 'category'},
  ],
};

/// Descriptor for `Ad`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adDescriptor = $convert.base64Decode(
    'CgJBZBIOCgJpZBgBIAEoA1ICaWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEhQKBXByaWNlGAMgAS'
    'gDUgVwcmljZRIgCgtkZXNjcmlwdGlvbhgEIAEoCVILZGVzY3JpcHRpb24SFQoGaXNfZmF2GAUg'
    'ASgIUgVpc0ZhdhIbCglpc19hY3RpdmUYBiABKAhSCGlzQWN0aXZlEhQKBXZpZXdzGAcgASgFUg'
    'V2aWV3cxIYCgdjcmVhdGVkGAogASgJUgdjcmVhdGVkEh8KBHVzZXIYCyABKAsyCy5ib2FyZC5V'
    'c2VyUgR1c2VyEisKCGNhdGVnb3J5GAwgASgLMg8uYm9hcmQuQ2F0ZWdvcnlSCGNhdGVnb3J5');

@$core.Deprecated('Use repeatedAdResponseDescriptor instead')
const RepeatedAdResponse$json = {
  '1': 'RepeatedAdResponse',
  '2': [
    {'1': 'data', '3': 1, '4': 3, '5': 11, '6': '.board.Ad', '10': 'data'},
  ],
};

/// Descriptor for `RepeatedAdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List repeatedAdResponseDescriptor = $convert.base64Decode(
    'ChJSZXBlYXRlZEFkUmVzcG9uc2USHQoEZGF0YRgBIAMoCzIJLmJvYXJkLkFkUgRkYXRh');

@$core.Deprecated('Use repeatedImageResponseDescriptor instead')
const RepeatedImageResponse$json = {
  '1': 'RepeatedImageResponse',
  '2': [
    {'1': 'data', '3': 1, '4': 3, '5': 11, '6': '.board.ImageProto', '10': 'data'},
  ],
};

/// Descriptor for `RepeatedImageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List repeatedImageResponseDescriptor = $convert.base64Decode(
    'ChVSZXBlYXRlZEltYWdlUmVzcG9uc2USJQoEZGF0YRgBIAMoCzIRLmJvYXJkLkltYWdlUHJvdG'
    '9SBGRhdGE=');

@$core.Deprecated('Use getAllCategoriesResponseDescriptor instead')
const GetAllCategoriesResponse$json = {
  '1': 'GetAllCategoriesResponse',
  '2': [
    {'1': 'categories', '3': 1, '4': 3, '5': 11, '6': '.board.Category', '10': 'categories'},
  ],
};

/// Descriptor for `GetAllCategoriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAllCategoriesResponseDescriptor = $convert.base64Decode(
    'ChhHZXRBbGxDYXRlZ29yaWVzUmVzcG9uc2USLwoKY2F0ZWdvcmllcxgBIAMoCzIPLmJvYXJkLk'
    'NhdGVnb3J5UgpjYXRlZ29yaWVz');

@$core.Deprecated('Use categoryDescriptor instead')
const Category$json = {
  '1': 'Category',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'path', '3': 3, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `Category`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryDescriptor = $convert.base64Decode(
    'CghDYXRlZ29yeRIOCgJpZBgBIAEoBFICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRISCgRwYXRoGA'
    'MgASgJUgRwYXRo');

