import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(
          '404 - Page not found!',
        ),
      ),
    );
  }
}

Function() errorSnail(BuildContext context, Function() tryDo) {
  return () {
    try {
      tryDo();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text((e as GrpcError).message ?? "$e"),
        ),
      );
    }
  };
}