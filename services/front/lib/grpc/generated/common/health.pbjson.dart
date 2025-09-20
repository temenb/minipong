//
//  Generated code. Do not modify.
//  source: common/health.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use healthReportDescriptor instead')
const HealthReport$json = {
  '1': 'HealthReport',
  '2': [
    {'1': 'components', '3': 1, '4': 3, '5': 11, '6': '.common.health.HealthReport.ComponentsEntry', '10': 'components'},
    {'1': 'healthy', '3': 2, '4': 1, '5': 8, '10': 'healthy'},
  ],
  '3': [HealthReport_ComponentsEntry$json],
};

@$core.Deprecated('Use healthReportDescriptor instead')
const HealthReport_ComponentsEntry$json = {
  '1': 'ComponentsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `HealthReport`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthReportDescriptor = $convert.base64Decode(
    'CgxIZWFsdGhSZXBvcnQSSwoKY29tcG9uZW50cxgBIAMoCzIrLmNvbW1vbi5oZWFsdGguSGVhbH'
    'RoUmVwb3J0LkNvbXBvbmVudHNFbnRyeVIKY29tcG9uZW50cxIYCgdoZWFsdGh5GAIgASgIUgdo'
    'ZWFsdGh5Gj0KD0NvbXBvbmVudHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIA'
    'EoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use statusInfoDescriptor instead')
const StatusInfo$json = {
  '1': 'StatusInfo',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'version', '3': 2, '4': 1, '5': 9, '10': 'version'},
    {'1': 'uptime', '3': 4, '4': 1, '5': 1, '10': 'uptime'},
    {'1': 'env', '3': 5, '4': 1, '5': 9, '10': 'env'},
    {'1': 'timestamp', '3': 6, '4': 1, '5': 9, '10': 'timestamp'},
  ],
};

/// Descriptor for `StatusInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statusInfoDescriptor = $convert.base64Decode(
    'CgpTdGF0dXNJbmZvEhIKBG5hbWUYASABKAlSBG5hbWUSGAoHdmVyc2lvbhgCIAEoCVIHdmVyc2'
    'lvbhIWCgZ1cHRpbWUYBCABKAFSBnVwdGltZRIQCgNlbnYYBSABKAlSA2VudhIcCgl0aW1lc3Rh'
    'bXAYBiABKAlSCXRpbWVzdGFtcA==');

@$core.Deprecated('Use liveStatusDescriptor instead')
const LiveStatus$json = {
  '1': 'LiveStatus',
  '2': [
    {'1': 'live', '3': 1, '4': 1, '5': 8, '10': 'live'},
  ],
};

/// Descriptor for `LiveStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List liveStatusDescriptor = $convert.base64Decode(
    'CgpMaXZlU3RhdHVzEhIKBGxpdmUYASABKAhSBGxpdmU=');

@$core.Deprecated('Use readyStatusDescriptor instead')
const ReadyStatus$json = {
  '1': 'ReadyStatus',
  '2': [
    {'1': 'ready', '3': 1, '4': 1, '5': 8, '10': 'ready'},
  ],
};

/// Descriptor for `ReadyStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readyStatusDescriptor = $convert.base64Decode(
    'CgtSZWFkeVN0YXR1cxIUCgVyZWFkeRgBIAEoCFIFcmVhZHk=');

