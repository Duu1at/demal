import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@immutable
final class SupabaseGoogleSignService {
  const SupabaseGoogleSignService({
    required this.webClientId,
    required this.iosClientId,
    required this.googleSignIn,
    required this.supabase,
  });

  final String webClientId;
  final String iosClientId;
  final GoogleSignIn googleSignIn;
  final Supabase supabase;

  Future<AuthResponse?> signInWithGoogle() async {
    try {
      await googleSignIn.initialize(
        clientId: iosClientId,
        serverClientId: webClientId,
      );

      GoogleSignInAccount? googleUser;

      if (googleSignIn.supportsAuthenticate()) {
        final completer = Completer<GoogleSignInAccount?>();
        StreamSubscription<dynamic>? subscription;

        subscription = googleSignIn.authenticationEvents.listen((event) async {
          if (event is GoogleSignInAuthenticationEventSignIn) {
            await subscription?.cancel();
            if (!completer.isCompleted) {
              completer.complete(event.user);
            }
          } else if (event is GoogleSignInAuthenticationEventSignOut) {
            await subscription?.cancel();
            if (!completer.isCompleted) {
              completer.complete(null);
            }
          }
        });

        await googleSignIn.authenticate();
        googleUser = await completer.future.timeout(
          const Duration(seconds: 30),
          onTimeout: () async {
            await subscription?.cancel();
            return null;
          },
        );
      } else {
        throw UnsupportedError(
          'Google Sign-In authenticate() not supported on this platform',
        );
      }

      if (googleUser == null) return null;

      final googleAuth = googleUser.authentication;
      final scopes = ['email', 'profile'];

      final authorization =
          await googleUser.authorizationClient.authorizationForScopes(scopes) ??
          await googleUser.authorizationClient.authorizeScopes(scopes);

      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw const AuthException('No ID Token found.');
      }

      final authResponse = await supabase.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
      );
      return authResponse;
    } on Exception {
      throw const AuthException('Supabase initialize failed.');
    }
  }

  Future<void> deleteAccount() async {
    try {
      await supabase.client.rpc<void>('delete_user');
      await supabase.client.auth.signOut();
      await googleSignIn.disconnect();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logOut() async {
    try {
      await supabase.client.auth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
