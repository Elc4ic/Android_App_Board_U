package org.example.Server.Service;

import io.grpc.stub.StreamObserver;
import lombok.AllArgsConstructor;
import net.devh.boot.grpc.server.service.GrpcService;
import org.example.Server.Entity.Category;
import org.example.Server.Repository.CategoryRepository;
import service.Board;

import java.util.List;

@GrpcService
@AllArgsConstructor
public class CategoryServiceGrpc extends service.CategoryServiceGrpc.CategoryServiceImplBase {

    private final CategoryRepository categoryRepository;

    @Override
    public void getAllCategory(Board.Empty request, StreamObserver<Board.ListCategory> responseObserver) {
        List<Category> categories = categoryRepository.findAll();
        responseObserver.onNext(Board.ListCategory.newBuilder().build());
        for (Category category : categories) {
            responseObserver.onNext(Board.ListCategory.newBuilder().addCategories(next(category)).build());
        }
        responseObserver.onCompleted();
    }

    private Board.Category next(Category category) {
        return Board.Category.newBuilder()
                .setId(category.getId())
                .setName(category.getName())
                .build();
    }
}
