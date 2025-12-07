import 'package:app/app/router/app_router.dart';
import 'package:app/features/shared/login/cubit/otp_cubit.dart';
import 'package:app/utils/utils.dart';
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
  late final TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _phoneController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBgImage(
      bgImageTop: true,
      appBar: AppBar(elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),

              Text(
                'Подвердите свой номер телефона',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              Text(
                'Мы отправим вам SMS с кодом\n на номер +996 ${_phoneController.text.isNotEmpty ? _phoneController.text : '(___) ___ ___'}',
                style: Theme.of(context).primaryTextTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              PhoneField(
                controller: _phoneController,
                inputFormatters: [InputFormatters.phoneFormatter],
                validator: InputValidators.phoneValidatorWithout996,
              ),
              const SizedBox(height: AppSpacing.lg),

              BlocConsumer<OtpCubit, OtpState>(
                listenWhen: (previous, current) => previous.sendStatus != current.sendStatus,
                listener: (context, state) {
                  final sendStatus = state.sendStatus;
                  switch (sendStatus) {
                    case RequestSuccess():
                      context.goNamed(
                        AppRoutes.otp,
                        extra: OtpArgs(
                          phoneNumber: InputFormatters.phoneFormatter.getUnmaskedText(),
                          otpCubit: context.read<OtpCubit>(),
                        ),
                      );
                    case RequestFailure():
                      context.read<ErrorHandler>().handleError(
                        sendStatus.exception,
                        context,
                      );
                    default:
                      break;
                  }
                },
                buildWhen: (previous, current) => previous.sendStatus != current.sendStatus,
                builder: (context, state) {
                  return AppButton(
                    isLoading: state.sendStatus is RequestLoading,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final phoneNumber = InputFormatters.phoneFormatter.getUnmaskedText();
                        context.read<OtpCubit>().sendOtp(phoneNumber);
                      }
                    },
                    child: const Text('Подтверждать'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
