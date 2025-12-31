import 'package:core/core.dart';
import 'package:meta/meta.dart';
import 'package:profile_repository/profile_repository.dart';

@immutable
final class ProfileRepositoryMockImpl implements ProfileRepository {
  const ProfileRepositoryMockImpl({
    this.mockVerificationStatus,
    this.mockProfile,
    this.delay = const Duration(milliseconds: 500),
  });

  final PartnerVerifyStatusEnum? mockVerificationStatus;
  final PartnerProfileModel? mockProfile;
  final Duration delay;

  @override
  Future<UserModel> getProfile() async {
    await Future<void>.delayed(delay);
    const user = UserModel(
      userId: 'test-user-id',
      phoneNumber: '+996702313611',
      fullName: 'Test User',
      role: RoleEnum.PARTNER,
      imageUrl: null,
      createdAt: '2024-01-01T00:00:00.000Z',
      partnerProfile: null,
    );
    return user;
  }

  @override
  Future<UserModel> updateProfile(ProfileUpdateParam param) async {
    await Future<void>.delayed(delay);
    final user = UserModel(
      userId: 'test-user-id',
      phoneNumber: '+996702313611',
      fullName: param.fullName ?? 'Test User',
      role: RoleEnum.PARTNER,
      imageUrl: param.imageUrl,
      createdAt: '2024-01-01T00:00:00.000Z',
      partnerProfile: null,
    );
    return user;
  }

  @override
  UserModel getProfileFromLocal() {
    const user = UserModel(
      userId: 'test-user-id',
      phoneNumber: '+996702313611',
      fullName: 'Test User',
      role: RoleEnum.PARTNER,
      imageUrl: null,
      createdAt: '2024-01-01T00:00:00.000Z',
      partnerProfile: null,
    );
    return user;
  }

  @override
  Future<PartnerVerifyStatusModel> getPartnerVerifyStatus() async {
    await Future<void>.delayed(delay);
    if (mockVerificationStatus == null) {
      throw Exception('Partner profile not found');
    }

    return PartnerVerifyStatusModel(
      success: true,
      verificationStatus: mockVerificationStatus,
      adminComments: mockVerificationStatus == PartnerVerifyStatusEnum.rejected
          ? 'Документы не соответствуют требованиям. Пожалуйста, загрузите более качественные фото.'
          : mockVerificationStatus == PartnerVerifyStatusEnum.verified
          ? 'Профиль успешно верифицирован'
          : 'Заявка находится на проверке',
      submittedAt: DateTime.now().subtract(const Duration(days: 1)),
      reviewedAt: mockVerificationStatus != PartnerVerifyStatusEnum.pending ? DateTime.now() : null,
    );
  }

  @override
  Future<PartnerProfileModel> updatePartnerProfile(PartnerProfileParam param) async {
    await Future<void>.delayed(delay);
    return PartnerProfileModel(
      profileId: 'test-profile-id',
      companyName: param.companyName,
      description: param.description,
      documentsUrl: param.documentsUrl,
      cardNumber: param.cardNumber,
      verificationStatus: PartnerVerifyStatusEnum.pending,
    );
  }

  @override
  Future<void> deleteProfileData() async {
    await Future<void>.delayed(delay);
  }
}
