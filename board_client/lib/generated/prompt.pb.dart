//
//  Generated code. Do not modify.
//  source: prompt.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'ad.pb.dart' as $1;
import 'user.pb.dart' as $0;

class GetManyPromptsRequest extends $pb.GeneratedMessage {
  factory GetManyPromptsRequest({
    $core.String? query,
    $core.String? token,
  }) {
    final $result = create();
    if (query != null) {
      $result.query = query;
    }
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  GetManyPromptsRequest._() : super();
  factory GetManyPromptsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetManyPromptsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetManyPromptsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..aOS(4, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetManyPromptsRequest clone() => GetManyPromptsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetManyPromptsRequest copyWith(void Function(GetManyPromptsRequest) updates) => super.copyWith((message) => updates(message as GetManyPromptsRequest)) as GetManyPromptsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetManyPromptsRequest create() => GetManyPromptsRequest._();
  GetManyPromptsRequest createEmptyInstance() => create();
  static $pb.PbList<GetManyPromptsRequest> createRepeated() => $pb.PbList<GetManyPromptsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetManyPromptsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetManyPromptsRequest>(create);
  static GetManyPromptsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => clearField(1);

  @$pb.TagNumber(4)
  $core.String get token => $_getSZ(1);
  @$pb.TagNumber(4)
  set token($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(4)
  $core.bool hasToken() => $_has(1);
  @$pb.TagNumber(4)
  void clearToken() => clearField(4);
}

class ChangePromptRequest extends $pb.GeneratedMessage {
  factory ChangePromptRequest({
    Prompt? prompt,
    $core.String? token,
  }) {
    final $result = create();
    if (prompt != null) {
      $result.prompt = prompt;
    }
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  ChangePromptRequest._() : super();
  factory ChangePromptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChangePromptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChangePromptRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aOM<Prompt>(1, _omitFieldNames ? '' : 'prompt', subBuilder: Prompt.create)
    ..aOS(2, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChangePromptRequest clone() => ChangePromptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChangePromptRequest copyWith(void Function(ChangePromptRequest) updates) => super.copyWith((message) => updates(message as ChangePromptRequest)) as ChangePromptRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChangePromptRequest create() => ChangePromptRequest._();
  ChangePromptRequest createEmptyInstance() => create();
  static $pb.PbList<ChangePromptRequest> createRepeated() => $pb.PbList<ChangePromptRequest>();
  @$core.pragma('dart2js:noInline')
  static ChangePromptRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangePromptRequest>(create);
  static ChangePromptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Prompt get prompt => $_getN(0);
  @$pb.TagNumber(1)
  set prompt(Prompt v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPrompt() => $_has(0);
  @$pb.TagNumber(1)
  void clearPrompt() => clearField(1);
  @$pb.TagNumber(1)
  Prompt ensurePrompt() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get token => $_getSZ(1);
  @$pb.TagNumber(2)
  set token($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearToken() => clearField(2);
}

class SetPerformRequest extends $pb.GeneratedMessage {
  factory SetPerformRequest({
    $fixnum.Int64? id,
    $core.String? token,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  SetPerformRequest._() : super();
  factory SetPerformRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetPerformRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetPerformRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetPerformRequest clone() => SetPerformRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetPerformRequest copyWith(void Function(SetPerformRequest) updates) => super.copyWith((message) => updates(message as SetPerformRequest)) as SetPerformRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetPerformRequest create() => SetPerformRequest._();
  SetPerformRequest createEmptyInstance() => create();
  static $pb.PbList<SetPerformRequest> createRepeated() => $pb.PbList<SetPerformRequest>();
  @$core.pragma('dart2js:noInline')
  static SetPerformRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetPerformRequest>(create);
  static SetPerformRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get token => $_getSZ(1);
  @$pb.TagNumber(2)
  set token($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearToken() => clearField(2);
}

class PaginatedPrompt extends $pb.GeneratedMessage {
  factory PaginatedPrompt({
    $core.Iterable<Prompt>? data,
    $fixnum.Int64? count,
    $fixnum.Int64? total,
    $fixnum.Int64? page,
    $fixnum.Int64? pageCount,
  }) {
    final $result = create();
    if (data != null) {
      $result.data.addAll(data);
    }
    if (count != null) {
      $result.count = count;
    }
    if (total != null) {
      $result.total = total;
    }
    if (page != null) {
      $result.page = page;
    }
    if (pageCount != null) {
      $result.pageCount = pageCount;
    }
    return $result;
  }
  PaginatedPrompt._() : super();
  factory PaginatedPrompt.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaginatedPrompt.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaginatedPrompt', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..pc<Prompt>(1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.PM, subBuilder: Prompt.create)
    ..aInt64(2, _omitFieldNames ? '' : 'count')
    ..aInt64(3, _omitFieldNames ? '' : 'total')
    ..aInt64(4, _omitFieldNames ? '' : 'page')
    ..aInt64(5, _omitFieldNames ? '' : 'pageCount')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaginatedPrompt clone() => PaginatedPrompt()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaginatedPrompt copyWith(void Function(PaginatedPrompt) updates) => super.copyWith((message) => updates(message as PaginatedPrompt)) as PaginatedPrompt;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaginatedPrompt create() => PaginatedPrompt._();
  PaginatedPrompt createEmptyInstance() => create();
  static $pb.PbList<PaginatedPrompt> createRepeated() => $pb.PbList<PaginatedPrompt>();
  @$core.pragma('dart2js:noInline')
  static PaginatedPrompt getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaginatedPrompt>(create);
  static PaginatedPrompt? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Prompt> get data => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get count => $_getI64(1);
  @$pb.TagNumber(2)
  set count($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCount() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get total => $_getI64(2);
  @$pb.TagNumber(3)
  set total($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotal() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotal() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get page => $_getI64(3);
  @$pb.TagNumber(4)
  set page($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPage() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get pageCount => $_getI64(4);
  @$pb.TagNumber(5)
  set pageCount($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPageCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearPageCount() => clearField(5);
}

class Prompt extends $pb.GeneratedMessage {
  factory Prompt({
    $fixnum.Int64? id,
    $core.String? title,
    $fixnum.Int64? reward,
    $core.String? description,
    $core.bool? isActive,
    $core.int? views,
    $core.Iterable<$core.String>? images,
    $core.String? address,
    $core.String? created,
    $0.User? owner,
    $0.User? performer,
    $1.Category? category,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (title != null) {
      $result.title = title;
    }
    if (reward != null) {
      $result.reward = reward;
    }
    if (description != null) {
      $result.description = description;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (views != null) {
      $result.views = views;
    }
    if (images != null) {
      $result.images.addAll(images);
    }
    if (address != null) {
      $result.address = address;
    }
    if (created != null) {
      $result.created = created;
    }
    if (owner != null) {
      $result.owner = owner;
    }
    if (performer != null) {
      $result.performer = performer;
    }
    if (category != null) {
      $result.category = category;
    }
    return $result;
  }
  Prompt._() : super();
  factory Prompt.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Prompt.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Prompt', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aInt64(3, _omitFieldNames ? '' : 'reward')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOB(6, _omitFieldNames ? '' : 'isActive')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'views', $pb.PbFieldType.O3)
    ..pPS(8, _omitFieldNames ? '' : 'images')
    ..aOS(9, _omitFieldNames ? '' : 'address')
    ..aOS(10, _omitFieldNames ? '' : 'created')
    ..aOM<$0.User>(11, _omitFieldNames ? '' : 'owner', subBuilder: $0.User.create)
    ..aOM<$0.User>(12, _omitFieldNames ? '' : 'performer', subBuilder: $0.User.create)
    ..aOM<$1.Category>(13, _omitFieldNames ? '' : 'category', subBuilder: $1.Category.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Prompt clone() => Prompt()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Prompt copyWith(void Function(Prompt) updates) => super.copyWith((message) => updates(message as Prompt)) as Prompt;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Prompt create() => Prompt._();
  Prompt createEmptyInstance() => create();
  static $pb.PbList<Prompt> createRepeated() => $pb.PbList<Prompt>();
  @$core.pragma('dart2js:noInline')
  static Prompt getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Prompt>(create);
  static Prompt? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get reward => $_getI64(2);
  @$pb.TagNumber(3)
  set reward($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReward() => $_has(2);
  @$pb.TagNumber(3)
  void clearReward() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(6)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(6)
  set isActive($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(6)
  void clearIsActive() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get views => $_getIZ(5);
  @$pb.TagNumber(7)
  set views($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasViews() => $_has(5);
  @$pb.TagNumber(7)
  void clearViews() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.String> get images => $_getList(6);

  @$pb.TagNumber(9)
  $core.String get address => $_getSZ(7);
  @$pb.TagNumber(9)
  set address($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasAddress() => $_has(7);
  @$pb.TagNumber(9)
  void clearAddress() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get created => $_getSZ(8);
  @$pb.TagNumber(10)
  set created($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreated() => $_has(8);
  @$pb.TagNumber(10)
  void clearCreated() => clearField(10);

  @$pb.TagNumber(11)
  $0.User get owner => $_getN(9);
  @$pb.TagNumber(11)
  set owner($0.User v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasOwner() => $_has(9);
  @$pb.TagNumber(11)
  void clearOwner() => clearField(11);
  @$pb.TagNumber(11)
  $0.User ensureOwner() => $_ensure(9);

  @$pb.TagNumber(12)
  $0.User get performer => $_getN(10);
  @$pb.TagNumber(12)
  set performer($0.User v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasPerformer() => $_has(10);
  @$pb.TagNumber(12)
  void clearPerformer() => clearField(12);
  @$pb.TagNumber(12)
  $0.User ensurePerformer() => $_ensure(10);

  @$pb.TagNumber(13)
  $1.Category get category => $_getN(11);
  @$pb.TagNumber(13)
  set category($1.Category v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasCategory() => $_has(11);
  @$pb.TagNumber(13)
  void clearCategory() => clearField(13);
  @$pb.TagNumber(13)
  $1.Category ensureCategory() => $_ensure(11);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
