//
//  Generated code. Do not modify.
//  source: ad.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'image.pb.dart' as $3;
import 'user.pb.dart' as $0;

class Empty extends $pb.GeneratedMessage {
  factory Empty() => create();
  Empty._() : super();
  factory Empty.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Empty.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Empty', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Empty clone() => Empty()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Empty copyWith(void Function(Empty) updates) => super.copyWith((message) => updates(message as Empty)) as Empty;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Empty create() => Empty._();
  Empty createEmptyInstance() => create();
  static $pb.PbList<Empty> createRepeated() => $pb.PbList<Empty>();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Empty>(create);
  static Empty? _defaultInstance;
}

class GetManyAdRequest extends $pb.GeneratedMessage {
  factory GetManyAdRequest({
    FilterQuery? filter,
    $fixnum.Int64? limit,
    $fixnum.Int64? page,
    $core.String? token,
  }) {
    final $result = create();
    if (filter != null) {
      $result.filter = filter;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (page != null) {
      $result.page = page;
    }
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  GetManyAdRequest._() : super();
  factory GetManyAdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetManyAdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetManyAdRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aOM<FilterQuery>(1, _omitFieldNames ? '' : 'filter', subBuilder: FilterQuery.create)
    ..aInt64(2, _omitFieldNames ? '' : 'limit')
    ..aInt64(3, _omitFieldNames ? '' : 'page')
    ..aOS(4, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetManyAdRequest clone() => GetManyAdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetManyAdRequest copyWith(void Function(GetManyAdRequest) updates) => super.copyWith((message) => updates(message as GetManyAdRequest)) as GetManyAdRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetManyAdRequest create() => GetManyAdRequest._();
  GetManyAdRequest createEmptyInstance() => create();
  static $pb.PbList<GetManyAdRequest> createRepeated() => $pb.PbList<GetManyAdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetManyAdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetManyAdRequest>(create);
  static GetManyAdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  FilterQuery get filter => $_getN(0);
  @$pb.TagNumber(1)
  set filter(FilterQuery v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => clearField(1);
  @$pb.TagNumber(1)
  FilterQuery ensureFilter() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get limit => $_getI64(1);
  @$pb.TagNumber(2)
  set limit($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get page => $_getI64(2);
  @$pb.TagNumber(3)
  set page($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get token => $_getSZ(3);
  @$pb.TagNumber(4)
  set token($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearToken() => clearField(4);
}

class FilterQuery extends $pb.GeneratedMessage {
  factory FilterQuery({
    $core.String? search,
    $fixnum.Int64? priceMax,
    $fixnum.Int64? priceMin,
    $core.String? address,
    Category? category,
  }) {
    final $result = create();
    if (search != null) {
      $result.search = search;
    }
    if (priceMax != null) {
      $result.priceMax = priceMax;
    }
    if (priceMin != null) {
      $result.priceMin = priceMin;
    }
    if (address != null) {
      $result.address = address;
    }
    if (category != null) {
      $result.category = category;
    }
    return $result;
  }
  FilterQuery._() : super();
  factory FilterQuery.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FilterQuery.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FilterQuery', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'search')
    ..aInt64(2, _omitFieldNames ? '' : 'priceMax')
    ..aInt64(3, _omitFieldNames ? '' : 'priceMin')
    ..aOS(4, _omitFieldNames ? '' : 'address')
    ..aOM<Category>(5, _omitFieldNames ? '' : 'category', subBuilder: Category.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FilterQuery clone() => FilterQuery()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FilterQuery copyWith(void Function(FilterQuery) updates) => super.copyWith((message) => updates(message as FilterQuery)) as FilterQuery;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FilterQuery create() => FilterQuery._();
  FilterQuery createEmptyInstance() => create();
  static $pb.PbList<FilterQuery> createRepeated() => $pb.PbList<FilterQuery>();
  @$core.pragma('dart2js:noInline')
  static FilterQuery getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FilterQuery>(create);
  static FilterQuery? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get search => $_getSZ(0);
  @$pb.TagNumber(1)
  set search($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSearch() => $_has(0);
  @$pb.TagNumber(1)
  void clearSearch() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get priceMax => $_getI64(1);
  @$pb.TagNumber(2)
  set priceMax($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPriceMax() => $_has(1);
  @$pb.TagNumber(2)
  void clearPriceMax() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get priceMin => $_getI64(2);
  @$pb.TagNumber(3)
  set priceMin($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPriceMin() => $_has(2);
  @$pb.TagNumber(3)
  void clearPriceMin() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get address => $_getSZ(3);
  @$pb.TagNumber(4)
  set address($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearAddress() => clearField(4);

  @$pb.TagNumber(5)
  Category get category => $_getN(4);
  @$pb.TagNumber(5)
  set category(Category v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => clearField(5);
  @$pb.TagNumber(5)
  Category ensureCategory() => $_ensure(4);
}

class GetByIdRequest extends $pb.GeneratedMessage {
  factory GetByIdRequest({
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
  GetByIdRequest._() : super();
  factory GetByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetByIdRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetByIdRequest clone() => GetByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetByIdRequest copyWith(void Function(GetByIdRequest) updates) => super.copyWith((message) => updates(message as GetByIdRequest)) as GetByIdRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetByIdRequest create() => GetByIdRequest._();
  GetByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetByIdRequest> createRepeated() => $pb.PbList<GetByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetByIdRequest>(create);
  static GetByIdRequest? _defaultInstance;

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

class ChangeAdRequest extends $pb.GeneratedMessage {
  factory ChangeAdRequest({
    Ad? ad,
    $core.Iterable<$3.ImageProto>? images,
    $core.String? token,
  }) {
    final $result = create();
    if (ad != null) {
      $result.ad = ad;
    }
    if (images != null) {
      $result.images.addAll(images);
    }
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  ChangeAdRequest._() : super();
  factory ChangeAdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChangeAdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChangeAdRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aOM<Ad>(1, _omitFieldNames ? '' : 'ad', subBuilder: Ad.create)
    ..pc<$3.ImageProto>(2, _omitFieldNames ? '' : 'images', $pb.PbFieldType.PM, subBuilder: $3.ImageProto.create)
    ..aOS(3, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChangeAdRequest clone() => ChangeAdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChangeAdRequest copyWith(void Function(ChangeAdRequest) updates) => super.copyWith((message) => updates(message as ChangeAdRequest)) as ChangeAdRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChangeAdRequest create() => ChangeAdRequest._();
  ChangeAdRequest createEmptyInstance() => create();
  static $pb.PbList<ChangeAdRequest> createRepeated() => $pb.PbList<ChangeAdRequest>();
  @$core.pragma('dart2js:noInline')
  static ChangeAdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangeAdRequest>(create);
  static ChangeAdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Ad get ad => $_getN(0);
  @$pb.TagNumber(1)
  set ad(Ad v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAd() => $_has(0);
  @$pb.TagNumber(1)
  void clearAd() => clearField(1);
  @$pb.TagNumber(1)
  Ad ensureAd() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$3.ImageProto> get images => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get token => $_getSZ(2);
  @$pb.TagNumber(3)
  set token($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearToken() => clearField(3);
}

class GetByIdWithBoolRequest extends $pb.GeneratedMessage {
  factory GetByIdWithBoolRequest({
    $fixnum.Int64? id,
    $core.String? token,
    $core.bool? value,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (token != null) {
      $result.token = token;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  GetByIdWithBoolRequest._() : super();
  factory GetByIdWithBoolRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetByIdWithBoolRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetByIdWithBoolRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'token')
    ..aOB(3, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetByIdWithBoolRequest clone() => GetByIdWithBoolRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetByIdWithBoolRequest copyWith(void Function(GetByIdWithBoolRequest) updates) => super.copyWith((message) => updates(message as GetByIdWithBoolRequest)) as GetByIdWithBoolRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetByIdWithBoolRequest create() => GetByIdWithBoolRequest._();
  GetByIdWithBoolRequest createEmptyInstance() => create();
  static $pb.PbList<GetByIdWithBoolRequest> createRepeated() => $pb.PbList<GetByIdWithBoolRequest>();
  @$core.pragma('dart2js:noInline')
  static GetByIdWithBoolRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetByIdWithBoolRequest>(create);
  static GetByIdWithBoolRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.bool get value => $_getBF(2);
  @$pb.TagNumber(3)
  set value($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearValue() => clearField(3);
}

class PaginatedAd extends $pb.GeneratedMessage {
  factory PaginatedAd({
    $core.Iterable<Ad>? data,
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
  PaginatedAd._() : super();
  factory PaginatedAd.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaginatedAd.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaginatedAd', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..pc<Ad>(1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.PM, subBuilder: Ad.create)
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
  PaginatedAd clone() => PaginatedAd()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaginatedAd copyWith(void Function(PaginatedAd) updates) => super.copyWith((message) => updates(message as PaginatedAd)) as PaginatedAd;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaginatedAd create() => PaginatedAd._();
  PaginatedAd createEmptyInstance() => create();
  static $pb.PbList<PaginatedAd> createRepeated() => $pb.PbList<PaginatedAd>();
  @$core.pragma('dart2js:noInline')
  static PaginatedAd getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaginatedAd>(create);
  static PaginatedAd? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Ad> get data => $_getList(0);

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

class Ad extends $pb.GeneratedMessage {
  factory Ad({
    $fixnum.Int64? id,
    $core.String? title,
    $fixnum.Int64? price,
    $core.String? description,
    $core.bool? isFav,
    $core.bool? isActive,
    $core.int? views,
    $core.String? created,
    $0.User? user,
    Category? category,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (title != null) {
      $result.title = title;
    }
    if (price != null) {
      $result.price = price;
    }
    if (description != null) {
      $result.description = description;
    }
    if (isFav != null) {
      $result.isFav = isFav;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (views != null) {
      $result.views = views;
    }
    if (created != null) {
      $result.created = created;
    }
    if (user != null) {
      $result.user = user;
    }
    if (category != null) {
      $result.category = category;
    }
    return $result;
  }
  Ad._() : super();
  factory Ad.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Ad.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Ad', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aInt64(3, _omitFieldNames ? '' : 'price')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOB(5, _omitFieldNames ? '' : 'isFav')
    ..aOB(6, _omitFieldNames ? '' : 'isActive')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'views', $pb.PbFieldType.O3)
    ..aOS(10, _omitFieldNames ? '' : 'created')
    ..aOM<$0.User>(11, _omitFieldNames ? '' : 'user', subBuilder: $0.User.create)
    ..aOM<Category>(12, _omitFieldNames ? '' : 'category', subBuilder: Category.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Ad clone() => Ad()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Ad copyWith(void Function(Ad) updates) => super.copyWith((message) => updates(message as Ad)) as Ad;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Ad create() => Ad._();
  Ad createEmptyInstance() => create();
  static $pb.PbList<Ad> createRepeated() => $pb.PbList<Ad>();
  @$core.pragma('dart2js:noInline')
  static Ad getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Ad>(create);
  static Ad? _defaultInstance;

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
  $fixnum.Int64 get price => $_getI64(2);
  @$pb.TagNumber(3)
  set price($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrice() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isFav => $_getBF(4);
  @$pb.TagNumber(5)
  set isFav($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsFav() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsFav() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isActive => $_getBF(5);
  @$pb.TagNumber(6)
  set isActive($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsActive() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsActive() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get views => $_getIZ(6);
  @$pb.TagNumber(7)
  set views($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasViews() => $_has(6);
  @$pb.TagNumber(7)
  void clearViews() => clearField(7);

  @$pb.TagNumber(10)
  $core.String get created => $_getSZ(7);
  @$pb.TagNumber(10)
  set created($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreated() => $_has(7);
  @$pb.TagNumber(10)
  void clearCreated() => clearField(10);

  @$pb.TagNumber(11)
  $0.User get user => $_getN(8);
  @$pb.TagNumber(11)
  set user($0.User v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasUser() => $_has(8);
  @$pb.TagNumber(11)
  void clearUser() => clearField(11);
  @$pb.TagNumber(11)
  $0.User ensureUser() => $_ensure(8);

  @$pb.TagNumber(12)
  Category get category => $_getN(9);
  @$pb.TagNumber(12)
  set category(Category v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCategory() => $_has(9);
  @$pb.TagNumber(12)
  void clearCategory() => clearField(12);
  @$pb.TagNumber(12)
  Category ensureCategory() => $_ensure(9);
}

class RepeatedAdResponse extends $pb.GeneratedMessage {
  factory RepeatedAdResponse({
    $core.Iterable<Ad>? data,
  }) {
    final $result = create();
    if (data != null) {
      $result.data.addAll(data);
    }
    return $result;
  }
  RepeatedAdResponse._() : super();
  factory RepeatedAdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RepeatedAdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RepeatedAdResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..pc<Ad>(1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.PM, subBuilder: Ad.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RepeatedAdResponse clone() => RepeatedAdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RepeatedAdResponse copyWith(void Function(RepeatedAdResponse) updates) => super.copyWith((message) => updates(message as RepeatedAdResponse)) as RepeatedAdResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RepeatedAdResponse create() => RepeatedAdResponse._();
  RepeatedAdResponse createEmptyInstance() => create();
  static $pb.PbList<RepeatedAdResponse> createRepeated() => $pb.PbList<RepeatedAdResponse>();
  @$core.pragma('dart2js:noInline')
  static RepeatedAdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RepeatedAdResponse>(create);
  static RepeatedAdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Ad> get data => $_getList(0);
}

class RepeatedImageResponse extends $pb.GeneratedMessage {
  factory RepeatedImageResponse({
    $core.Iterable<$3.ImageProto>? data,
  }) {
    final $result = create();
    if (data != null) {
      $result.data.addAll(data);
    }
    return $result;
  }
  RepeatedImageResponse._() : super();
  factory RepeatedImageResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RepeatedImageResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RepeatedImageResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..pc<$3.ImageProto>(1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.PM, subBuilder: $3.ImageProto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RepeatedImageResponse clone() => RepeatedImageResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RepeatedImageResponse copyWith(void Function(RepeatedImageResponse) updates) => super.copyWith((message) => updates(message as RepeatedImageResponse)) as RepeatedImageResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RepeatedImageResponse create() => RepeatedImageResponse._();
  RepeatedImageResponse createEmptyInstance() => create();
  static $pb.PbList<RepeatedImageResponse> createRepeated() => $pb.PbList<RepeatedImageResponse>();
  @$core.pragma('dart2js:noInline')
  static RepeatedImageResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RepeatedImageResponse>(create);
  static RepeatedImageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$3.ImageProto> get data => $_getList(0);
}

class GetAllCategoriesResponse extends $pb.GeneratedMessage {
  factory GetAllCategoriesResponse({
    $core.Iterable<Category>? categories,
  }) {
    final $result = create();
    if (categories != null) {
      $result.categories.addAll(categories);
    }
    return $result;
  }
  GetAllCategoriesResponse._() : super();
  factory GetAllCategoriesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAllCategoriesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAllCategoriesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..pc<Category>(1, _omitFieldNames ? '' : 'categories', $pb.PbFieldType.PM, subBuilder: Category.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAllCategoriesResponse clone() => GetAllCategoriesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAllCategoriesResponse copyWith(void Function(GetAllCategoriesResponse) updates) => super.copyWith((message) => updates(message as GetAllCategoriesResponse)) as GetAllCategoriesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAllCategoriesResponse create() => GetAllCategoriesResponse._();
  GetAllCategoriesResponse createEmptyInstance() => create();
  static $pb.PbList<GetAllCategoriesResponse> createRepeated() => $pb.PbList<GetAllCategoriesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAllCategoriesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAllCategoriesResponse>(create);
  static GetAllCategoriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Category> get categories => $_getList(0);
}

class Category extends $pb.GeneratedMessage {
  factory Category({
    $fixnum.Int64? id,
    $core.String? name,
    $core.String? path,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (path != null) {
      $result.path = path;
    }
    return $result;
  }
  Category._() : super();
  factory Category.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Category.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Category', package: const $pb.PackageName(_omitMessageNames ? '' : 'board'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'path')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Category clone() => Category()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Category copyWith(void Function(Category) updates) => super.copyWith((message) => updates(message as Category)) as Category;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Category create() => Category._();
  Category createEmptyInstance() => create();
  static $pb.PbList<Category> createRepeated() => $pb.PbList<Category>();
  @$core.pragma('dart2js:noInline')
  static Category getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Category>(create);
  static Category? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get path => $_getSZ(2);
  @$pb.TagNumber(3)
  set path($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPath() => $_has(2);
  @$pb.TagNumber(3)
  void clearPath() => clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
