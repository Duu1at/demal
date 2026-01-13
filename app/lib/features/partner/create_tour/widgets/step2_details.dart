import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Step2Details extends StatefulWidget {
  const Step2Details({super.key});

  @override
  State<Step2Details> createState() => _Step2DetailsState();
}

class _Step2DetailsState extends State<Step2Details> {
  late final TextEditingController _descriptionController;
  late final TextEditingController _meetingPointAddressController;
  late final TextEditingController _meetingPointCoordinatesController;
  late final TextEditingController _whatToBringController;

  @override
  void initState() {
    super.initState();
    final state = context.read<CreateTourFormCubit>().state;
    _descriptionController = TextEditingController(text: state.description);
    _meetingPointAddressController = TextEditingController(text: state.meetingPointAddress);
    _meetingPointCoordinatesController = TextEditingController(text: state.meetingPointCoordinates);
    _whatToBringController = TextEditingController(text: state.whatToBring);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _meetingPointAddressController.dispose();
    _meetingPointCoordinatesController.dispose();
    _whatToBringController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTourFormCubit, CreateTourFormState>(
      listenWhen: (previous, current) => previous.tourId != current.tourId,
      listener: (context, state) {
        if (state.description != _descriptionController.text) {
          _descriptionController.text = state.description;
        }
        if (state.meetingPointAddress != _meetingPointAddressController.text) {
          _meetingPointAddressController.text = state.meetingPointAddress;
        }
        if (state.meetingPointCoordinates != _meetingPointCoordinatesController.text) {
          _meetingPointCoordinatesController.text = state.meetingPointCoordinates;
        }
        if (state.whatToBring != _whatToBringController.text) {
          _whatToBringController.text = state.whatToBring;
        }
      },
      builder: (context, state) {
        return ScrollableBody(
          listViewChildren: [
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
              hintText: 'Подробное описание тура',
              maxLines: 5,
              controller: _descriptionController,
              onChanged: (value) => context.read<CreateTourFormCubit>().updateDescription(value),
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
              label: const Text('Точка встречи'),
              hintText: 'Адрес места встречи',
              controller: _meetingPointAddressController,
              onChanged: (value) => context.read<CreateTourFormCubit>().updateMeetingPointAddress(value),
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
              label: const Text('Что взять с собой'),
              hintText: 'Рекомендации для участников',
              maxLines: 3,
              controller: _whatToBringController,
              onChanged: (value) => context.read<CreateTourFormCubit>().updateWhatToBring(value),
            ),
            const SizedBox(height: AppSpacing.lg),
            TourItemsListInput(
              title: 'Что включено',
              items: state.whatsIncluded,
              onAdd: (item) => context.read<CreateTourFormCubit>().addWhatsIncluded(item),
              onRemove: (index) => context.read<CreateTourFormCubit>().removeWhatsIncluded(index),
            ),
            const SizedBox(height: AppSpacing.lg),
            TourItemsListInput(
              title: 'Что не включено',
              items: state.whatsNotIncluded,
              onAdd: (item) => context.read<CreateTourFormCubit>().addWhatsNotIncluded(item),
              onRemove: (index) => context.read<CreateTourFormCubit>().removeWhatsNotIncluded(index),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          ],
          columnChildren: const [],
        );
      },
    );
  }
}
