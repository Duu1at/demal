import 'package:app/app/app.dart';
import 'package:app/features/client/client.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:finik_sdk/finik_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FinikPaymentView extends StatefulWidget {
  const FinikPaymentView(this.args, {super.key});

  final FinikPaymentArgs args;

  @override
  State<FinikPaymentView> createState() => _FinikPaymentViewState();
}

class _FinikPaymentViewState extends State<FinikPaymentView> {
  bool _handled = false;

  String? get _apiKey => dotenv.env['FINIK_KEY'];
  String? get _accountId => dotenv.env['FINIK_ACCOUNT_ID'];

  void _showError(String message) {
    AppSnackbar.showError(context: context, title: message);
  }

  void _showInfo(String message) {
    AppSnackbar.showInfo(context: context, title: message);
  }

  Future<void> _handlePaymentResult(Object? data) async {
    final state = context.read<FinikPaymentBloc>().state;
    if (_handled || state is FinikPaymentVerifying) return;

    final paymentStatus = ((data is Map ? data['status'] : null) ?? '').toString().toUpperCase();
    if (paymentStatus != 'SUCCEEDED') {
      _handled = true;
      context.read<FinikPaymentBloc>().add(const FinikPaymentFailedReported());
      return;
    }

    context.read<FinikPaymentBloc>().add(
      FinikPaymentVerifyRequested(widget.args.bookingId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final apiKey = _apiKey;
    final accountId = _accountId;
    if (apiKey == null || apiKey.isEmpty || accountId == null || accountId.isEmpty) {
      return ScaffoldWithBgImage(
        appBar: AppBar(title: const Text('Payment')),
        body: const Center(
          child: Text('Missing FINIK_API_KEY or FINIK_ACCOUNT_ID in .env'),
        ),
      );
    }

    return BlocListener<FinikPaymentBloc, FinikPaymentState>(
      listener: (context, state) {
        if (state is FinikPaymentPaid) {
          _handled = true;
          context.goNamed(AppRouteNames.clientBookingStatus);
          return;
        }
        if (state is FinikPaymentProcessing) {
          _handled = true;
          _showInfo('Payment is processing. Please check My Tickets later.');
          context.pop();
          return;
        }
        if (state is FinikPaymentFailed) {
          _showError('Payment failed or cancelled');
          context.pop();
          return;
        }
        if (state is FinikPaymentError) {
          context.read<ErrorHandler>().handleError(state.error, context);
          context.pop();
        }
      },
      child: BlocBuilder<FinikPaymentBloc, FinikPaymentState>(
        builder: (context, state) {
          final isVerifying = state is FinikPaymentVerifying;
          return Scaffold(
            body: Stack(
              children: [
                FinikProvider(
                  apiKey: apiKey,
                  isBeta: false,
                  locale: FinikSdkLocale.RU,
                  textScenario: TextScenario.PAYMENT,
                  paymentMethods: const [PaymentMethod.APP, PaymentMethod.QR],
                  onBackPressed: () => context.pop(),
                  onPayment: _handlePaymentResult,
                  widget: CreateItemHandlerWidget(
                    accountId: accountId,
                    nameEn: widget.args.itemName,
                    requestId: widget.args.requestId,
                    amount: FixedAmount(widget.args.amount.toDouble()),
                    description: 'Tour booking payment (10%)',
                  ),
                ),
                if (isVerifying)
                  const ColoredBox(
                    color: Color(0x66000000),
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

final class FinikPaymentArgs {
  const FinikPaymentArgs({
    required this.bookingId,
    required this.requestId,
    required this.amount,
    required this.itemName,
  });

  final String bookingId;
  final String requestId;
  final int amount;
  final String itemName;
}
