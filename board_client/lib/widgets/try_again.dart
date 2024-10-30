

import 'package:flutter/material.dart';
import 'package:grpc/grpc_connection_interface.dart';

class TryAgainWidget extends StatelessWidget {
  const TryAgainWidget(
      {super.key, required this.exception, required this.onPressed});

  final Object? exception;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    var error = exception as GrpcError;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("${error.codeName} -> ${error.message}",
              style: Theme.of(context).textTheme.bodyMedium),
          TextButton(
            onPressed: onPressed,
            child: Text('Try againg',
                style: Theme.of(context).textTheme.titleMedium),
          ),
        ],
      ),
    );
  }
}
