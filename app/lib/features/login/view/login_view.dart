import 'package:app/app/router/app_router.dart';
import 'package:app/features/login/cubit/otp_cubit.dart';
import 'package:app/features/login/widgets/email_field.dart';
import 'package:app_ui/app_ui.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storage/storage.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpCubit(
        context.read<AuthRepository>(),
        context.read<PreferencesStorage>(),
      ),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => __LoginViewState();
}

class __LoginViewState extends State<_LoginView> {
  late final TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _emailController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBgImage(
      bgImageTop: true,
      appBar: AppBar(elevation: 0),
      body: ScrollableForm(
        formKey: _formKey,
        listViewChildren: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Assets.images.logo.image(),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Добро пожаловать!',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          EmailField(
            controller: _emailController,
            hintText: 'example@gmail.com',
            label: 'Email',
          ),
          const SizedBox(height: AppSpacing.xlg),
          BlocConsumer<OtpCubit, OtpState>(
            listenWhen: (previous, current) => previous.sendStatus != current.sendStatus,
            listener: (context, state) {
              final sendStatus = state.sendStatus;
              switch (sendStatus) {
                case RequestSuccess():
                  context.goNamed(
                    AppRoutes.otp,
                    extra: OtpArgs(
                      email: _emailController.text,
                      otpCubit: context.read<OtpCubit>(),
                    ),
                  );
                case RequestFailure():
                  context.read<ErrorHandler>().handleError(sendStatus.exception, context);
                default:
                  break;
              }
            },
            buildWhen: (previous, current) => previous.sendStatus != current.sendStatus,
            builder: (context, state) {
              return AppButton(
                isLoading: state.sendStatus is RequestLoading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<OtpCubit>().sendOtp(_emailController.text);
                  }
                },
                child: const Text('Войти'),
              );
            },
          ),
        ],
        columnChildren: [
          AppButton(
            variant: AppButtonVariant.outline,
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icons.google.svg(
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: AppSpacing.lg),
                Text(
                  'Войти через Google',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            variant: AppButtonVariant.outline,
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icons.apple.svg(
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: AppSpacing.lg),
                Text(
                  'Войти через Apple',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _formKey.currentState?.dispose();
    _emailController.removeListener(() => setState(() {}));
    super.dispose();
  }
}
