package com.example.boardserver.service

import adProto.AdOuterClass
import com.example.boardserver.dto.AdUtils
import com.example.boardserver.repository.AdRepository
import com.example.boardserver.repository.CategoryRepository
import com.google.protobuf.Empty
import io.grpc.stub.StreamObserver
import net.devh.boot.grpc.server.service.GrpcService
import org.springframework.data.domain.PageRequest

@GrpcService
class AdService(
    private val adRepository: AdRepository,
    private val categoryRepository: CategoryRepository
) : adProto.AdAPIGrpc.AdAPIImplBase() {

    override fun getManyAd(
        request: AdOuterClass.GetManyAdRequest?,
        responseObserver: StreamObserver<AdOuterClass.PaginatedAd>?
    ) {
        val adPage = adRepository.findAll(PageRequest.of(request!!.page.toInt(), request.limit.toInt()))
        println("something do")
        val total = adRepository.count()
        val pageCount = total / request.limit + 1
        responseObserver?.onNext(
            AdUtils.toPaginatedAdGrpc(adPage, request.page, total, pageCount)
        )
        responseObserver?.onCompleted()
    }

    override fun getOneAd(request: AdOuterClass.GetOneAdRequest?, responseObserver: StreamObserver<AdOuterClass.Ad>?) {
        val ad = request?.let { adRepository.findById(it.id) }
        responseObserver?.onNext(ad?.let { AdUtils.toAdGrpc(it.get()) })
        responseObserver?.onCompleted()
    }

    override fun setFavoriteAd(
        request: AdOuterClass.SetFavoriteOneAdRequest?,
        responseObserver: StreamObserver<Empty>?
    ) {
        val ad = request?.let { adRepository.findById(it.id) }
        ad.let { AdUtils.ChangeAdFav(it!!.get()) }.let { adRepository.save(it) }
        responseObserver?.onNext(Empty.newBuilder().build())
        responseObserver?.onCompleted()
    }

    override fun addAd(request: AdOuterClass.Ad?, responseObserver: StreamObserver<Empty>?) {
        request.let { AdUtils.fromAdGrpc(it!!) }.let { adRepository.save(it) }
        responseObserver?.onNext(Empty.newBuilder().build())
        responseObserver?.onCompleted()
    }
}