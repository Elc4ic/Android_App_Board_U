part of 'widgets.dart';

class TryAgainWidget extends StatelessWidget {
  const TryAgainWidget(
      {super.key, required this.exception, required this.onPressed});

  final Object? exception;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(exception.toString()),
          const Text('Please try againg later'),
          TextButton(
            onPressed: onPressed,
            child: const Text('Try againg'),
          ),
        ],
      ),
    );
  }
}

