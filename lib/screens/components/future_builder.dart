import 'package:flutter/material.dart';

class QFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function()? loading;
  final Widget Function(dynamic)? error;
  final Widget Function(T)? data;

  const QFutureBuilder(
      {super.key,
      required this.future,
      required this.loading,
      required this.error,
      required this.data});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loading != null
                ? loading!()
                : const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return error != null
                ? error!(snapshot.error)
                : Text('Error : ${snapshot.hasError}');
          } else if (snapshot.hasData) {
            return data != null
                ? data!(snapshot.data as T)
                : Text('${snapshot.data}');
          } else {
            return Container();
          }
        });
  }
}
