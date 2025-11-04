import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Un widget genérico que envuelve un BlocBuilder.
/// Puedes reutilizarlo con cualquier Cubit/Bloc y cualquier estado.
class StateBuilderGW<B extends StateStreamable<S>, S> extends StatelessWidget {
  const StateBuilderGW({
    super.key,
    required this.builder,
    this.loading,
    this.error,
    this.empty,
    this.isLoading,
    this.isError,
    this.isEmpty,
  });
  final Widget Function(BuildContext context, S state) builder;
  final Widget? loading;
  final Widget? error;
  final Widget? empty;
  final bool Function(S state)? isLoading;
  final bool Function(S state)? isError;
  final bool Function(S state)? isEmpty;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        if (isLoading?.call(state) ?? false) {
          return loading ??
              const Center(child: CircularProgressIndicator.adaptive());
        }
        if (isError?.call(state) ?? false) {
          return error ?? const Center(child: Text('An error occurred.'));
        }
        if (isEmpty?.call(state) ?? false) {
          return empty ?? const Center(child: Text('No data available.'));
        }
        return builder(context, state);
      },
    );
  }
}
