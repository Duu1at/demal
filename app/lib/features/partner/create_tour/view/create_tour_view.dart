import 'package:app/features/features.dart';
import 'package:app/utils/image_picker_service/image_picker_service.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour_repository/tour_repository.dart';
import 'package:upload_repository/upload_repository.dart';

class CreateTourView extends StatelessWidget {
  const CreateTourView({super.key, this.tour});

  final TourModel? tour;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateTourFormCubit(
            tourRepository: context.read<TourRepository>(),
            uploadRepository: context.read<UploadRepository>(),
            tour: tour,
          ),
        ),
        BlocProvider(
          create: (context) => TourMediaCubit(
            imagePickerService: ImagePickerService(ImagePicker()),
            uploadRepository: context.read<UploadRepository>(),
          ),
        ),
      ],
      child: const _CreateTourViewContent(),
    );
  }
}

class _CreateTourViewContent extends StatelessWidget {
  const _CreateTourViewContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTourFormCubit, CreateTourFormState>(
      listener: (context, state) {
        if (state.error != null) {
          context.read<ErrorHandler>().handleError(state.error!, context);
        }
        if (state.isSuccess) {
          context.pop(true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.tourId != null ? 'Редактирование тура' : 'Создание тура'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(6),
              child: _ProgressIndicator(currentStep: state.currentStep),
            ),
          ),
          body: _buildStepContent(context, state.currentStep),
          floatingActionButton: CreateTourActionButton(
            currentStep: state.currentStep,
            canProceed: _canProceed(state),
            canSubmit: state.canSubmit,
            isSubmitting: state.isSubmitting,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildStepContent(BuildContext context, CreateTourStep step) {
    switch (step) {
      case CreateTourStep.basicInfo:
        return const Step1BasicInfo();
      case CreateTourStep.details:
        return const Step2Details();
      case CreateTourStep.media:
        return const Step3Media();
    }
  }

  bool _canProceed(CreateTourFormState state) {
    switch (state.currentStep) {
      case CreateTourStep.basicInfo:
        return state.canProceedToStep2;
      case CreateTourStep.details:
        return state.canProceedToStep3;
      case CreateTourStep.media:
        return false;
    }
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({required this.currentStep});

  final CreateTourStep currentStep;

  @override
  Widget build(BuildContext context) {
    final progress = (currentStep.index + 1) / 3;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: Colors.grey[200],
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class CreateTourActionButton extends StatelessWidget {
  const CreateTourActionButton({
    required this.currentStep,
    required this.canProceed,
    required this.canSubmit,
    required this.isSubmitting,
    super.key,
  });

  final CreateTourStep currentStep;
  final bool canProceed;
  final bool canSubmit;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      fullWidth: false,
      isLoading: isSubmitting,
      onPressed: () {
        if (currentStep == CreateTourStep.media) {
          if (canSubmit) {
            context.read<CreateTourFormCubit>().submit();
          }
        } else {
          if (canProceed) {
            context.read<CreateTourFormCubit>().nextStep();
          }
        }
      },
      child: Text(
        currentStep == CreateTourStep.media ? 'Сохранить' : 'Далее',
      ),
    );
  }
}
