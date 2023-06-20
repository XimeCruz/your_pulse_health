import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:your_pulse_health/core/extensions/exceptions.dart';
import 'package:your_pulse_health/core/const/global_constants.dart';
import 'package:your_pulse_health/core/service/user_storage_service.dart';
import 'package:your_pulse_health/data/user_data.dart';

class AuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User> signUp(String email, String password, String name) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    final User user = result.user!;
    await user.updateDisplayName(name);

    final userData = UserData.fromFirebase(auth.currentUser);
    await UserStorageService.writeSecureData(email, userData is UserData? jsonEncode(userData.toJson()):"");
    GlobalConstants.currentUser = userData;

    return user;
  }

  static Future resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseException(getExceptionMessage(e));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? user = result.user;

      if (user == null) {
        throw Exception("Usuario no encontrado");
      } else {
        final userFromLocal = await UserStorageService.readSecureData(email);
        final userData = UserData.fromFirebase(auth.currentUser);
        //print(userData.toJson());
        if (userFromLocal == null) {

          await UserStorageService.writeSecureData(
             // email, userData.toJsonString());
          email, (userData.toJson()).toString());

        }
        GlobalConstants.currentUser = userData;
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseException(getExceptionMessage(e));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }
}

String getExceptionMessage(FirebaseAuthException e) {
  print(e.code);
  switch (e.code) {
    case 'user-not-found':
      return 'Usuario no encontrado';
    case 'wrong-password':
      return 'Contraseña incorrecta';
    case 'requires-recent-login':
      return 'Vuelva a iniciar sesión antes de intentar esta solicitud';
    default:
      return e.message ?? 'Error';
  }
}
