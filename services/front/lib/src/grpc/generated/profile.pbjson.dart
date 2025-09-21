//
//  Generated code. Do not modify.
//  source: profile.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use upsertRequestDescriptor instead')
const UpsertRequest$json = {
  '1': 'UpsertRequest',
  '2': [
    {'1': 'owner_id', '3': 1, '4': 1, '5': 9, '10': 'ownerId'},
  ],
};

/// Descriptor for `UpsertRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upsertRequestDescriptor = $convert.base64Decode(
    'Cg1VcHNlcnRSZXF1ZXN0EhkKCG93bmVyX2lkGAEgASgJUgdvd25lcklk');

@$core.Deprecated('Use viewRequestDescriptor instead')
const ViewRequest$json = {
  '1': 'ViewRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `ViewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List viewRequestDescriptor = $convert.base64Decode(
    'CgtWaWV3UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use profileResponseDescriptor instead')
const ProfileResponse$json = {
  '1': 'ProfileResponse',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'owner_id', '3': 2, '4': 1, '5': 9, '10': 'ownerId'},
    {'1': 'nickname', '3': 3, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `ProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List profileResponseDescriptor = $convert.base64Decode(
    'Cg9Qcm9maWxlUmVzcG9uc2USDgoCaWQYASABKAlSAmlkEhkKCG93bmVyX2lkGAIgASgJUgdvd2'
    '5lcklkEhoKCG5pY2tuYW1lGAMgASgJUghuaWNrbmFtZQ==');

@$core.Deprecated('Use profileListResponseDescriptor instead')
const ProfileListResponse$json = {
  '1': 'ProfileListResponse',
  '2': [
    {'1': 'profiles', '3': 1, '4': 3, '5': 11, '6': '.profile.ProfileResponse', '10': 'profiles'},
  ],
};

/// Descriptor for `ProfileListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List profileListResponseDescriptor = $convert.base64Decode(
    'ChNQcm9maWxlTGlzdFJlc3BvbnNlEjQKCHByb2ZpbGVzGAEgAygLMhgucHJvZmlsZS5Qcm9maW'
    'xlUmVzcG9uc2VSCHByb2ZpbGVz');

