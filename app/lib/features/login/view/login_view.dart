import 'package:app/app/app.dart';
import 'package:app/features/login/login.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => OtpCubit(
            context.read<AuthRepository>(),
            context.read<PreferencesStorage>(),
          ),
        ),
        BlocProvider(
          create: (_) => GoogleSignCubit(
            context.read<AuthRepository>(),
          ),
        ),
        BlocProvider(
          create: (_) => AppleSignCubit(
            context.read<AuthRepository>(),
          ),
        ),
      ],
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
            context.l10n.welcome,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          EmailField(
            controller: _emailController,
            hintText: 'example@gmail.com',
            label: context.l10n.email,
          ),
          const SizedBox(height: AppSpacing.xlg),
          BlocConsumer<OtpCubit, OtpState>(
            listenWhen: (previous, current) => previous.sendStatus != current.sendStatus,
            listener: (context, state) {
              final sendStatus = state.sendStatus;
              switch (sendStatus) {
                case RequestSuccess():
                  context.pushNamed(
                    AppRouteNames.otp,
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
                child: Text(context.l10n.signIn),
              );
            },
          ),
        ],
        columnChildren: const [
          GoogleSignInButton(),
          SizedBox(height: AppSpacing.md),
          AppleSignInButton(),
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
