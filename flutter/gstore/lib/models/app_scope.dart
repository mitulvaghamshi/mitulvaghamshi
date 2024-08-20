import 'package:flutter/material.dart';
import 'package:gstore/models/app_state.dart';

@immutable
class AppScope extends InheritedWidget {
  const AppScope({super.key, required this.data, required super.child});

  final AppState data;

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    return ArgumentError.checkNotNull(scope).data;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      oldWidget is AppScope && oldWidget.data != data;
}
