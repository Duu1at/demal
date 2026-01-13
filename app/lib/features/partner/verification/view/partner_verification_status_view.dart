import 'package:app/app/app.dart';
import 'package:app/core/exceptions/exception.dart';
import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:profile_repository/profile_repository.dart';

class PartnerVerificationStatusView extends StatelessWidget {
  const PartnerVerificationStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyStatusCubit(
        context.read<ProfileRepository>(),
      )..getVerifyStatus(),
      child: const PartnerVerificationStatusViewBody(),
    );
  }
}

class PartnerVerificationStatusViewBody extends StatelessWidget {
  const PartnerVerificationStatusViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: ScaffoldWithBgImage(
        appBar: AppBar(
          title: const Text('Статус верификации'),
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => context.read<VerifyStatusCubit>().getVerifyStatus(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: BlocConsumer<VerifyStatusCubit, RequestStatus<PartnerVerifyStatusModel>>(
                  listener: (context, state) {
                    if (state is RequestSuccess<PartnerVerifyStatusModel>) {
                      if (state.data?.verificationStatus == PartnerVerifyStatusEnum.verified) {
                        context.read<AuthCubit>().updateProfile();
                      }
                    }
                  },
                  builder: (context, state) {
                    return switch (state) {
                      RequestInitial() => const SizedBox.shrink(),
                      RequestLoading() => const Center(child: CircularProgressIndicator.adaptive()),
                      RequestSuccess<PartnerVerifyStatusModel>(data: final data) => VerifySuccessView(data),
                      RequestFailure(:final exception) => Center(child: ErrorBodyWidget(exception)),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
