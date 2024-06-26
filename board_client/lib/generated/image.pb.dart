//
//  Generated code. Do not modify.
//  source: image.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ImageProto extends $pb.GeneratedMessage {
  factory ImageProto({
    $core.List<$core.int>? chunk,
  }) {
    final $result = create();
    if (chunk != null) {
      $result.chunk = chunk;
    }
    return $result;
  }
  ImageProto._() : super();
  factory ImageProto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImageProto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ImageProto', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'chunk', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImageProto clone() => ImageProto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImageProto copyWith(void Function(ImageProto) updates) => super.copyWith((message) => updates(message as ImageProto)) as ImageProto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImageProto create() => ImageProto._();
  ImageProto createEmptyInstance() => create();
  static $pb.PbList<ImageProto> createRepeated() => $pb.PbList<ImageProto>();
  @$core.pragma('dart2js:noInline')
  static ImageProto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImageProto>(create);
  static ImageProto? _defaultInstance;

  @$pb.TagNumber(2)
  $core.List<$core.int> get chunk => $_getN(0);
  @$pb.TagNumber(2)
  set chunk($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(2)
  $core.bool hasChunk() => $_has(0);
  @$pb.TagNumber(2)
  void clearChunk() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
