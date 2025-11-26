import 'package:app/features/partner/create_tour/cubit/create_tour_cubit.dart';
import 'package:app/features/partner/create_tour/widgets/step1_basic_info.dart';
import 'package:app/features/partner/create_tour/widgets/step2_details.dart';
import 'package:app/features/partner/create_tour/widgets/step3_media.dart';
import 'package:app/utils/image_picker_service/image_picker_service.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour_repository/tour_repository.dart';
import 'package:upload_repository/upload_repository.dart';

class CreateTourView extends StatelessWidget {
  const CreateTourView({super.key, this.tour});

  final TourModel? tour;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTourCubit(
        tourRepository: context.read<TourRepository>(),
        uploadRepository: context.read<UploadRepository>(),
        imagePickerService: ImagePickerService(ImagePicker()),
        tour: tour,
      ),
      child: const _CreateTourViewContent(),
    );
  }
}

class _CreateTourViewContent extends StatelessWidget {
  const _CreateTourViewContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTourCubit, CreateTourState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.toString().replaceAll('Exception: ', '')),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
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
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildStepContent(context, state.currentStep),
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

  bool _canProceed(CreateTourState state) {
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
            context.read<CreateTourCubit>().submit(context);
          }
        } else {
          if (canProceed) {
            context.read<CreateTourCubit>().nextStep();
          }
        }
      },
      child: Text(
        currentStep == CreateTourStep.media ? 'Сохранить' : 'Далее',
      ),
    );
  }
}
