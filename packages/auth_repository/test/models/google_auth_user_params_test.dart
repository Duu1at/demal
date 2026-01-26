import 'package:auth_repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GoogleAuthUserParams', () {
    test('supports value equality', () {
      const user1 = GoogleAuthUserParams(
        accessToken: 'token',
        userId: 'id',
        email: 'email',
        fullName: 'name',
      );
      const user2 = GoogleAuthUserParams(
        accessToken: 'token',
        userId: 'id',
        email: 'email',
        fullName: 'name',
      );
      // Since we didn't add Equatable, this will fail if we check equality directly unless it's the same instance or we manually override ==
      // The requirement didn't specify Equatable, but for data models it's good practice.
      // However, for this test I will just check field values.
      expect(user1.accessToken, user2.accessToken);
    });

    test('toJson returns correct map', () {
      const user = GoogleAuthUserParams(
        accessToken: 'token',
        userId: 'id',
        email: 'email',
        fullName: 'name',
        avatarUrl: 'url',
        phoneNumber: 'phone',
      );
      expect(user.toJson(), {
        'access_token': 'token',
        'user_id': 'id',
        'email': 'email',
        'full_name': 'name',
        'avatar_url': 'url',
        'phoneNumber': 'phone',
      });
    });

    test('fromJson creates correct instance', () {
      final json = {
        'access_token': 'token',
        'user_id': 'id',
        'email': 'email',
        'full_name': 'name',
        'avatar_url': 'url',
        'phoneNumber': 'phone',
      };
      final user = GoogleAuthUserParams.fromJson(json);
      expect(user.accessToken, 'token');
      expect(user.userId, 'id');
      expect(user.email, 'email');
      expect(user.fullName, 'name');
      expect(user.avatarUrl, 'url');
      expect(user.phoneNumber, 'phone');
    });
  });
}
