import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/common/exceptions.dart';
import 'package:store/ui/home/bloc/home_bloc.dart';

class AppErrorWidget extends StatelessWidget {
  final AppException exception;
  final GestureTapCallback onPressed;

  const AppErrorWidget({
    super.key,
    required this.exception,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(exception.message),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(onPressed: onPressed, child: Text('تلاش مجدد'))
        ],
      ),
    );
  }
}
