import 'package:app/client/home/blocs/tours/tours_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin ToursScrollControllerMixin<T extends StatefulWidget> on State<T> {
  late final ScrollController scrollController;

  static const double _scrollThreshold = 0.9;

  void initializeScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  void disposeScrollController() {
    scrollController.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ToursBloc>().add(const ToursLoadMoreEvent());
    }
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * _scrollThreshold);
  }
}
