package org.example.Server.Service;

import io.grpc.stub.StreamObserver;
import service.Board;

public class ChatServiceGrpc extends service.ChatServiceGrpc.ChatServiceImplBase{

    @Override
    public void createChat(Board.Message request, StreamObserver<Board.Chat> responseObserver) {
        super.createChat(request, responseObserver);
    }

    @Override
    public void getAllChat(Board.Empty request, StreamObserver<Board.ListChat> responseObserver) {
        super.getAllChat(request, responseObserver);
    }

    @Override
    public void deleteChat(Board.Id request, StreamObserver<Board.Empty> responseObserver) {
        super.deleteChat(request, responseObserver);
    }

    @Override
    public void sendMessage(Board.Message request, StreamObserver<Board.Message> responseObserver) {
        super.sendMessage(request, responseObserver);
    }

    @Override
    public void viewedMessage(Board.Empty request, StreamObserver<Board.Empty> responseObserver) {
        super.viewedMessage(request, responseObserver);
    }
}
