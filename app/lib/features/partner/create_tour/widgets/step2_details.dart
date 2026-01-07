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
              label: const Text('Координаты (опционально)'),
              hintText: 'Широта, долгота',
              controller: _meetingPointCoordinatesController,
              onChanged: (value) => context.read<CreateTourFormCubit>().updateMeetingPointCoordinates(value),
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
            _WhatsIncludedSection(
              items: state.whatsIncluded,
              onAdd: (item) => context.read<CreateTourFormCubit>().addWhatsIncluded(item),
              onRemove: (index) => context.read<CreateTourFormCubit>().removeWhatsIncluded(index),
            ),
            const SizedBox(height: AppSpacing.lg),
            _WhatsNotIncludedSection(
              items: state.whatsNotIncluded,
              onAdd: (item) => context.read<CreateTourFormCubit>().addWhatsNotIncluded(item),
              onRemove: (index) => context.read<CreateTourFormCubit>().removeWhatsNotIncluded(index),
            ),
          ],
          columnChildren: const [],
        );
      },
    );
  }
}

class _WhatsIncludedSection extends StatefulWidget {
  const _WhatsIncludedSection({
    required this.items,
    required this.onAdd,
    required this.onRemove,
  });

  final List<String> items;
  final void Function(String) onAdd;
  final void Function(int) onRemove;

  @override
  State<_WhatsIncludedSection> createState() => _WhatsIncludedSectionState();
}

class _WhatsIncludedSectionState extends State<_WhatsIncludedSection> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Что включено *',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
                hintText: 'Добавить пункт',
                controller: _controller,
                onChanged: (value) {},
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton(
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  widget.onAdd(_controller.text);
                  _controller.clear();
                }
              },
              icon: const Icon(Icons.add),
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ...widget.items.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Row(
              children: [
                Expanded(
                  child: Chip(
                    label: Text(entry.value),
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => widget.onRemove(entry.key),
                ),
              ],
            ),
          );
        }),
        if (widget.items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Text(
              'Добавьте хотя бы один пункт',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}

class _WhatsNotIncludedSection extends StatefulWidget {
  const _WhatsNotIncludedSection({
    required this.items,
    required this.onAdd,
    required this.onRemove,
  });

  final List<String> items;
  final void Function(String) onAdd;
  final void Function(int) onRemove;

  @override
  State<_WhatsNotIncludedSection> createState() => _WhatsNotIncludedSectionState();
}

class _WhatsNotIncludedSectionState extends State<_WhatsNotIncludedSection> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Что не включено *',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                hintText: 'Добавить пункт',
                controller: _controller,
                onChanged: (value) {},
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton(
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  widget.onAdd(_controller.text);
                  _controller.clear();
                }
              },
              icon: const Icon(Icons.add),
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ...widget.items.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Row(
              children: [
                Expanded(
                  child: Chip(
                    label: Text(entry.value),
                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => widget.onRemove(entry.key),
                ),
              ],
            ),
          );
        }),
        if (widget.items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Text(
              'Добавьте хотя бы один пункт',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}
