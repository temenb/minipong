// This is a generated file - do not edit.
//
// Generated from profile.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

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
final $typed_data.Uint8List upsertRequestDescriptor = $convert
    .base64Decode('Cg1VcHNlcnRSZXF1ZXN0EhkKCG93bmVyX2lkGAEgASgJUgdvd25lcklk');

@$core.Deprecated('Use viewRequestDescriptor instead')
const ViewRequest$json = {
  '1': 'ViewRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `ViewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List viewRequestDescriptor =
    $convert.base64Decode('CgtWaWV3UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use profileObjectDescriptor instead')
const ProfileObject$json = {
  '1': 'ProfileObject',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'owner_id', '3': 2, '4': 1, '5': 9, '10': 'ownerId'},
    {'1': 'nickname', '3': 3, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'level', '3': 4, '4': 1, '5': 3, '10': 'level'},
    {'1': 'rating', '3': 5, '4': 1, '5': 3, '10': 'rating'},
    {'1': 'experience', '3': 6, '4': 1, '5': 3, '10': 'experience'},
  ],
};

/// Descriptor for `ProfileObject`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List profileObjectDescriptor = $convert.base64Decode(
    'Cg1Qcm9maWxlT2JqZWN0Eg4KAmlkGAEgASgJUgJpZBIZCghvd25lcl9pZBgCIAEoCVIHb3duZX'
    'JJZBIaCghuaWNrbmFtZRgDIAEoCVIIbmlja25hbWUSFAoFbGV2ZWwYBCABKANSBWxldmVsEhYK'
    'BnJhdGluZxgFIAEoA1IGcmF0aW5nEh4KCmV4cGVyaWVuY2UYBiABKANSCmV4cGVyaWVuY2U=');
