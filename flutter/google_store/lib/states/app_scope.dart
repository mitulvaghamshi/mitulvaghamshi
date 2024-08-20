import 'package:flutter/material.dart';
import 'package:google_store/states/app_state.dart';

@immutable
class const AppScope({
  required final AppState data,
  required super.child,
  super.key,
}) extends InheritedWidget {
  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    return ArgumentError.checkNotNull(scope).data;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      oldWidget is AppScope && oldWidget.data != data;
}
