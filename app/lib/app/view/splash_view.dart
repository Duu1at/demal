import 'package:app/app/app.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onStateChanged(context.read<AuthCubit>().state);
    });
  }

  void _onStateChanged(AuthState state) {
    if (!mounted) return;
    if (state.status == AuthStatus.loading || state.status == AuthStatus.initial) return;

    if (state.status == AuthStatus.authenticated && state.user.isPartner) {
      context.goNamed(AppRouteNames.partner);
    } else {
      context.goNamed(AppRouteNames.client);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) => _onStateChanged(state),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: Assets.images.logo.image(width: 150),
        ),
      ),
    );
  }
}
