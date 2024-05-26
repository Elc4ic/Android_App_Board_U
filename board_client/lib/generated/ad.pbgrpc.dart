//
//  Generated code. Do not modify.
//  source: ad.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'ad.pb.dart' as $1;
import 'user.pb.dart' as $0;

export 'ad.pb.dart';

@$pb.GrpcServiceName('board.AdAPI')
class AdAPIClient extends $grpc.Client {
  static final _$getManyAd = $grpc.ClientMethod<$1.GetManyAdRequest, $1.PaginatedAd>(
      '/board.AdAPI/GetManyAd',
      ($1.GetManyAdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.PaginatedAd.fromBuffer(value));
  static final _$getOneAd = $grpc.ClientMethod<$1.GetByIdRequest, $1.Ad>(
      '/board.AdAPI/GetOneAd',
      ($1.GetByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Ad.fromBuffer(value));
  static final _$setFavoriteAd = $grpc.ClientMethod<$1.SetFavoriteRequest, $0.IsSuccess>(
      '/board.AdAPI/SetFavoriteAd',
      ($1.SetFavoriteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.IsSuccess.fromBuffer(value));
  static final _$addAd = $grpc.ClientMethod<$1.ChangeAdRequest, $0.IsSuccess>(
      '/board.AdAPI/AddAd',
      ($1.ChangeAdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.IsSuccess.fromBuffer(value));
  static final _$deleteAd = $grpc.ClientMethod<$1.ChangeAdRequest, $0.IsSuccess>(
      '/board.AdAPI/DeleteAd',
      ($1.ChangeAdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.IsSuccess.fromBuffer(value));
  static final _$muteAd = $grpc.ClientMethod<$1.ChangeAdRequest, $0.IsSuccess>(
      '/board.AdAPI/MuteAd',
      ($1.ChangeAdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.IsSuccess.fromBuffer(value));
  static final _$getFavoriteAds = $grpc.ClientMethod<$0.JwtProto, $1.RepeatedAdResponse>(
      '/board.AdAPI/GetFavoriteAds',
      ($0.JwtProto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.RepeatedAdResponse.fromBuffer(value));
  static final _$getMyAds = $grpc.ClientMethod<$0.JwtProto, $1.RepeatedAdResponse>(
      '/board.AdAPI/GetMyAds',
      ($0.JwtProto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.RepeatedAdResponse.fromBuffer(value));

  AdAPIClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.PaginatedAd> getManyAd($1.GetManyAdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getManyAd, request, options: options);
  }

  $grpc.ResponseFuture<$1.Ad> getOneAd($1.GetByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOneAd, request, options: options);
  }

  $grpc.ResponseFuture<$0.IsSuccess> setFavoriteAd($1.SetFavoriteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setFavoriteAd, request, options: options);
  }

  $grpc.ResponseFuture<$0.IsSuccess> addAd($1.ChangeAdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addAd, request, options: options);
  }

  $grpc.ResponseFuture<$0.IsSuccess> deleteAd($1.ChangeAdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAd, request, options: options);
  }

  $grpc.ResponseFuture<$0.IsSuccess> muteAd($1.ChangeAdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$muteAd, request, options: options);
  }

  $grpc.ResponseFuture<$1.RepeatedAdResponse> getFavoriteAds($0.JwtProto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFavoriteAds, request, options: options);
  }

  $grpc.ResponseFuture<$1.RepeatedAdResponse> getMyAds($0.JwtProto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyAds, request, options: options);
  }
}

@$pb.GrpcServiceName('board.AdAPI')
abstract class AdAPIServiceBase extends $grpc.Service {
  $core.String get $name => 'board.AdAPI';

  AdAPIServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.GetManyAdRequest, $1.PaginatedAd>(
        'GetManyAd',
        getManyAd_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetManyAdRequest.fromBuffer(value),
        ($1.PaginatedAd value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetByIdRequest, $1.Ad>(
        'GetOneAd',
        getOneAd_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetByIdRequest.fromBuffer(value),
        ($1.Ad value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SetFavoriteRequest, $0.IsSuccess>(
        'SetFavoriteAd',
        setFavoriteAd_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SetFavoriteRequest.fromBuffer(value),
        ($0.IsSuccess value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ChangeAdRequest, $0.IsSuccess>(
        'AddAd',
        addAd_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ChangeAdRequest.fromBuffer(value),
        ($0.IsSuccess value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ChangeAdRequest, $0.IsSuccess>(
        'DeleteAd',
        deleteAd_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ChangeAdRequest.fromBuffer(value),
        ($0.IsSuccess value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ChangeAdRequest, $0.IsSuccess>(
        'MuteAd',
        muteAd_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ChangeAdRequest.fromBuffer(value),
        ($0.IsSuccess value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JwtProto, $1.RepeatedAdResponse>(
        'GetFavoriteAds',
        getFavoriteAds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.JwtProto.fromBuffer(value),
        ($1.RepeatedAdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JwtProto, $1.RepeatedAdResponse>(
        'GetMyAds',
        getMyAds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.JwtProto.fromBuffer(value),
        ($1.RepeatedAdResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.PaginatedAd> getManyAd_Pre($grpc.ServiceCall call, $async.Future<$1.GetManyAdRequest> request) async {
    return getManyAd(call, await request);
  }

  $async.Future<$1.Ad> getOneAd_Pre($grpc.ServiceCall call, $async.Future<$1.GetByIdRequest> request) async {
    return getOneAd(call, await request);
  }

  $async.Future<$0.IsSuccess> setFavoriteAd_Pre($grpc.ServiceCall call, $async.Future<$1.SetFavoriteRequest> request) async {
    return setFavoriteAd(call, await request);
  }

  $async.Future<$0.IsSuccess> addAd_Pre($grpc.ServiceCall call, $async.Future<$1.ChangeAdRequest> request) async {
    return addAd(call, await request);
  }

  $async.Future<$0.IsSuccess> deleteAd_Pre($grpc.ServiceCall call, $async.Future<$1.ChangeAdRequest> request) async {
    return deleteAd(call, await request);
  }

  $async.Future<$0.IsSuccess> muteAd_Pre($grpc.ServiceCall call, $async.Future<$1.ChangeAdRequest> request) async {
    return muteAd(call, await request);
  }

  $async.Future<$1.RepeatedAdResponse> getFavoriteAds_Pre($grpc.ServiceCall call, $async.Future<$0.JwtProto> request) async {
    return getFavoriteAds(call, await request);
  }

  $async.Future<$1.RepeatedAdResponse> getMyAds_Pre($grpc.ServiceCall call, $async.Future<$0.JwtProto> request) async {
    return getMyAds(call, await request);
  }

  $async.Future<$1.PaginatedAd> getManyAd($grpc.ServiceCall call, $1.GetManyAdRequest request);
  $async.Future<$1.Ad> getOneAd($grpc.ServiceCall call, $1.GetByIdRequest request);
  $async.Future<$0.IsSuccess> setFavoriteAd($grpc.ServiceCall call, $1.SetFavoriteRequest request);
  $async.Future<$0.IsSuccess> addAd($grpc.ServiceCall call, $1.ChangeAdRequest request);
  $async.Future<$0.IsSuccess> deleteAd($grpc.ServiceCall call, $1.ChangeAdRequest request);
  $async.Future<$0.IsSuccess> muteAd($grpc.ServiceCall call, $1.ChangeAdRequest request);
  $async.Future<$1.RepeatedAdResponse> getFavoriteAds($grpc.ServiceCall call, $0.JwtProto request);
  $async.Future<$1.RepeatedAdResponse> getMyAds($grpc.ServiceCall call, $0.JwtProto request);
}
@$pb.GrpcServiceName('board.CategoryAPI')
class CategoryAPIClient extends $grpc.Client {
  static final _$getAllCategories = $grpc.ClientMethod<$1.Empty, $1.GetAllCategoriesResponse>(
      '/board.CategoryAPI/GetAllCategories',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetAllCategoriesResponse.fromBuffer(value));
  static final _$getCategory = $grpc.ClientMethod<$1.GetByIdRequest, $1.RepeatedAdResponse>(
      '/board.CategoryAPI/GetCategory',
      ($1.GetByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.RepeatedAdResponse.fromBuffer(value));

  CategoryAPIClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.GetAllCategoriesResponse> getAllCategories($1.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAllCategories, request, options: options);
  }

  $grpc.ResponseFuture<$1.RepeatedAdResponse> getCategory($1.GetByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCategory, request, options: options);
  }
}

@$pb.GrpcServiceName('board.CategoryAPI')
abstract class CategoryAPIServiceBase extends $grpc.Service {
  $core.String get $name => 'board.CategoryAPI';

  CategoryAPIServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.GetAllCategoriesResponse>(
        'GetAllCategories',
        getAllCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.GetAllCategoriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetByIdRequest, $1.RepeatedAdResponse>(
        'GetCategory',
        getCategory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetByIdRequest.fromBuffer(value),
        ($1.RepeatedAdResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.GetAllCategoriesResponse> getAllCategories_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return getAllCategories(call, await request);
  }

  $async.Future<$1.RepeatedAdResponse> getCategory_Pre($grpc.ServiceCall call, $async.Future<$1.GetByIdRequest> request) async {
    return getCategory(call, await request);
  }

  $async.Future<$1.GetAllCategoriesResponse> getAllCategories($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.RepeatedAdResponse> getCategory($grpc.ServiceCall call, $1.GetByIdRequest request);
}
