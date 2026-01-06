import 'package:app/app/app.dart';
import 'package:app/features/client/tours/bloc/tours_bloc.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ToursSearchBar extends StatelessWidget {
  const ToursSearchBar({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: SearchTextField(
        onChanged: (_) {},
        hintText: 'Search any tours...',
        controller: controller,
        onFilterTap: () => context.pushNamed(
          AppRouteNames.clientTourFilters,
          extra: context.read<ToursBloc>(),
        ),
      ),
    );
  }
}
