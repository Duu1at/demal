import 'dart:async';
import 'dart:convert';
import 'package:core/core.dart';
import 'package:crypto/crypto.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@immutable
final class SupabaseAppleSignService {
  const SupabaseAppleSignService({
    required this.supabase,
    required this.crashlyticsClient,
  });

  final Supabase supabase;
  final CrashlyticsClient crashlyticsClient;

  Future<AuthResponse?> signInWithApple() async {
    try {
      final rawNonce = supabase.client.auth.generateRawNonce();
      final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );
      final idToken = credential.identityToken;
      if (idToken == null) {
        throw const AuthException('Could not find ID Token from generated credential.');
      }
      final authResponse = await supabase.client.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
        nonce: rawNonce,
      );

      if (credential.givenName != null || credential.familyName != null) {
        final nameParts = <String>[];
        if (credential.givenName != null) nameParts.add(credential.givenName!);
        if (credential.familyName != null) nameParts.add(credential.familyName!);
        final fullName = nameParts.join(' ');
        await supabase.client.auth.updateUser(
          UserAttributes(
            data: {
              'full_name': fullName,
              'given_name': credential.givenName,
              'family_name': credential.familyName,
            },
          ),
        );
      }
      return authResponse;
    } on SignInWithAppleAuthorizationException catch (e, s) {
      if (e.code != AuthorizationErrorCode.canceled) {
        crashlyticsClient.report(e, s);
      }
      rethrow;
    } on Object catch (e, s) {
      crashlyticsClient.report(e, s);
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    try {
      await supabase.client.rpc<void>('delete_user');
      await supabase.client.auth.signOut();
    } on Object catch (e, s) {
      crashlyticsClient.report(e, s);
      rethrow;
    }
  }

  Future<void> logOut() async {
    try {
      await supabase.client.auth.signOut();
    } on Object catch (e, s) {
      crashlyticsClient.report(e, s);
      rethrow;
    }
  }
}
