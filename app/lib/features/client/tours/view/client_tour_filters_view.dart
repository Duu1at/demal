import 'package:app/features/client/tours/bloc/tours_bloc.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_repository/tour_repository.dart';

class ClientTourFiltersView extends StatefulWidget {
  const ClientTourFiltersView({super.key});

  @override
  State<ClientTourFiltersView> createState() => _ClientTourFiltersViewState();
}

class _ClientTourFiltersViewState extends State<ClientTourFiltersView> {
  final _formKey = GlobalKey<FormState>();

  final _locationController = TextEditingController();
  final _tourTypeController = TextEditingController();
  final _priceMinController = TextEditingController();
  final _priceMaxController = TextEditingController();

  String? _tourType;
  DateTime? _dateFrom;
  DateTime? _dateTo;
  double? _priceMin;
  double? _priceMax;
  TourSortBy? _sortBy;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final bloc = context.read<ToursBloc>();
        final state = bloc.state;
        final p = state.params;
        if (p != null) {
          setState(() {
            _locationController.text = p.location ?? '';
            _tourType = p.tourType;
            _tourTypeController.text = p.tourType ?? '';
            _dateFrom = _parseDate(p.dateFrom);
            _dateTo = _parseDate(p.dateTo);
            _priceMin = p.priceMin?.toDouble();
            _priceMax = p.priceMax?.toDouble();
            if (_priceMin != null) {
              _priceMinController.text = _priceMin!.toString();
            }
            if (_priceMax != null) {
              _priceMaxController.text = _priceMax!.toString();
            }
            _sortBy = p.sortBy;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _locationController.dispose();
    _tourTypeController.dispose();
    _priceMinController.dispose();
    _priceMaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.filtersTitle),
        actions: [TextButton(onPressed: _onReset, child: Text(context.l10n.reset))],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            children: [
              const SizedBox(height: AppSpacing.lg),
              Text(context.l10n.locationLabel, style: theme.textTheme.labelLarge),
              const SizedBox(height: AppSpacing.xs),
              AppTextField(
                controller: _locationController,
                hintText: context.l10n.locationHint,
              ),

              const SizedBox(height: AppSpacing.lg),
              Text(context.l10n.tourTypeLabel, style: theme.textTheme.labelLarge),
              const SizedBox(height: AppSpacing.xs),
              AppTextField(
                controller: _tourTypeController,
                hintText: context.l10n.tourTypeHint,
                onChanged: (v) => _tourType = v.trim().isEmpty ? null : v.trim(),
              ),

              const SizedBox(height: AppSpacing.lg),
              Text(context.l10n.dateRangeLabel, style: theme.textTheme.labelLarge),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: _DateField(
                      label: context.l10n.dateFromLabel,
                      value: _dateFrom,
                      onPick: (d) => setState(() => _dateFrom = d),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _DateField(
                      label: context.l10n.dateToLabel,
                      value: _dateTo,
                      onPick: (d) => setState(() => _dateTo = d),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.lg),
              Text(
                context.l10n.priceRangeLabel,
                style: theme.textTheme.labelLarge,
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      keyboardType: TextInputType.number,
                      controller: _priceMinController,
                      hintText: context.l10n.minHint,
                      onChanged: (v) => _priceMin = _toDoubleOrNull(v),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: AppTextField(
                      keyboardType: TextInputType.number,
                      controller: _priceMaxController,
                      hintText: context.l10n.maxHint,
                      onChanged: (v) => _priceMax = _toDoubleOrNull(v),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.lg),
              Text(context.l10n.sortByLabel, style: theme.textTheme.labelLarge),
              const SizedBox(height: AppSpacing.xs),
              DropdownButtonFormField<TourSortBy>(
                initialValue: _sortBy,
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    value: TourSortBy.dateAsc,
                    child: Text(context.l10n.sortDateAsc),
                  ),
                  DropdownMenuItem(
                    value: TourSortBy.dateDesc,
                    child: Text(context.l10n.sortDateDesc),
                  ),
                  DropdownMenuItem(
                    value: TourSortBy.priceAsc,
                    child: Text(context.l10n.sortPriceAsc),
                  ),
                  DropdownMenuItem(
                    value: TourSortBy.priceDesc,
                    child: Text(context.l10n.sortPriceDesc),
                  ),
                  DropdownMenuItem(
                    value: TourSortBy.ratingDesc,
                    child: Text(context.l10n.sortRatingDesc),
                  ),
                ],
                onChanged: (v) => setState(() => _sortBy = v),
              ),

              const SizedBox(height: AppSpacing.xl),
              AppButton(onPressed: _onApply, child: Text(context.l10n.apply)),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  void _onApply() {
    if (!_validateDateRange()) return;

    final params = ToursParam(
      location: _trimOrNull(_locationController.text),
      tourType: _tourType,
      dateFrom: _formatDate(_dateFrom),
      dateTo: _formatDate(_dateTo),
      priceMin: _priceMin,
      priceMax: _priceMax,
      sortBy: _sortBy,
    );

    context.read<ToursBloc>().add(ToursFilterChanged(params));
    Navigator.of(context).pop();
  }

  void _onReset() {
    setState(() {
      _tourType = null;
      _dateFrom = null;
      _dateTo = null;
      _priceMin = null;
      _priceMax = null;
      _sortBy = null;
      _locationController.clear();
      _tourTypeController.clear();
      _priceMinController.clear();
      _priceMaxController.clear();
    });
    context.read<ToursBloc>().add(const ToursFilterChanged(ToursParam()));
    Navigator.of(context).pop();
  }

  bool _validateDateRange() {
    if (_dateFrom != null && _dateTo != null && _dateFrom!.isAfter(_dateTo!)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.invalidDateRange)));
      return false;
    }
    return true;
  }

  static String? _formatDate(DateTime? d) {
    if (d == null) return null;
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  static DateTime? _parseDate(String? s) {
    if (s == null || s.isEmpty) return null;
    try {
      return DateTime.parse(s);
    } on Object catch (_) {
      return null;
    }
  }

  static String? _trimOrNull(String? s) {
    final t = s?.trim();
    if (t == null || t.isEmpty) return null;
    return t;
  }

  static double? _toDoubleOrNull(String? v) {
    if (v == null) return null;
    final t = v.trim();
    if (t.isEmpty) return null;
    return double.tryParse(t);
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onPick,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onPick;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        final now = DateTime.now();
        final initial = value ?? now;
        final picked = await showDatePicker(
          context: context,
          initialDate: initial,
          firstDate: DateTime(now.year - 5),
          lastDate: DateTime(now.year + 5),
        );
        onPick(picked);
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(value == null ? label : _formatted(value!)),
      ),
    );
  }

  static String _formatted(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }
}
