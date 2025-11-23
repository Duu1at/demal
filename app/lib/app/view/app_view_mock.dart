import 'package:api_client/api_client.dart';
import 'package:app/app/app.dart';
import 'package:app/core/exceptions/handle/app_exception_type_resolver.dart';
import 'package:app_ui/app_ui.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:bookings_repository/bookings_repository.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:storage/storage.dart';
import 'package:tour_repository/tour_repository.dart';
import 'package:upload_repository/upload_repository.dart';

/// Версия App с мок-данными для тестирования
class AppMock extends StatelessWidget {
  const AppMock({
    super.key,
    this.mockVerificationStatus,
  });

  /// Статус верификации для мока
  final PartnerVerifyStatusEnum? mockVerificationStatus;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<AppRepository>(
          create: (context) => AppRepositoryImpl(
            AppLocalDataSourceImpl(storage: context.read<PreferencesStorage>()),
          ),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            authLocalDataSource: AuthLocalDataSource(context.read<PreferencesStorage>()),
            authRemoteDataSource: AuthRemoteDataSource(context.read<ApiClient>()),
          ),
        ),
        RepositoryProvider<TourRepository>(
          create: (context) => TourRepositoryImpl(
            TourRemoteDataSource(context.read<ApiClient>()),
          ),
        ),
        RepositoryProvider<BookingsRepository>(
          create: (context) => BookingRepositoryImpl(
            BookingRemoteDataSource(context.read<ApiClient>()),
          ),
        ),
        // Используем мок для ProfileRepository
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepositoryMockImpl(
            mockVerificationStatus: mockVerificationStatus,
          ),
        ),
        // Используем мок для UploadRepository
        RepositoryProvider<UploadRepository>(
          create: (context) => const UploadRepositoryMockImpl(),
        ),
        RepositoryProvider<ErrorHandler>(create: (context) => const BaseErrorHandler()),
        RepositoryProvider<ErrorHandler>(create: (context) => const ErrorHandleSnackBar()),
        RepositoryProvider<ErrorHandler>(create: (context) => const ErrorHandleDialog()),
        BlocProvider<AppThemeCubit>(
          create: (context) => AppThemeCubit(context.read<AppRepository>()),
        ),
        BlocProvider<AppLocaleCubit>(
          create: (context) => AppLocaleCubit(context.read<AppRepository>()),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(context.read<AuthRepository>())..checkAuthStatus(),
        ),
      ],
      child: const DemalApp(),
    );
  }
}
