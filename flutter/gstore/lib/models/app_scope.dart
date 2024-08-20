import 'package:flutter/material.dart';
import 'package:gstore/models/app_state.dart';

@immutable
class AppScope extends InheritedWidget {
  const AppScope({super.key, required this.data, required super.child});

  final AppState data;

  static AppState of(final BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppScope>()!.data;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      oldWidget is AppScope && oldWidget.data != data;
}
