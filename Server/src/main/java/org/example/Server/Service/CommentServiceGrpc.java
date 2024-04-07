package org.example.Server.Service;

import io.grpc.stub.StreamObserver;
import service.Board;

public class CommentServiceGrpc extends service.CommentServiceGrpc.CommentServiceImplBase{

    @Override
    public void createComment(Board.Comment request, StreamObserver<Board.Empty> responseObserver) {
        super.createComment(request, responseObserver);
    }

    @Override
    public void getUserComments(Board.User request, StreamObserver<Board.ListComment> responseObserver) {
        super.getUserComments(request, responseObserver);
    }

    @Override
    public void deleteComment(Board.Id request, StreamObserver<Board.Empty> responseObserver) {
        super.deleteComment(request, responseObserver);
    }

    @Override
    public void updateComment(Board.Comment request, StreamObserver<Board.Empty> responseObserver) {
        super.updateComment(request, responseObserver);
    }


}
