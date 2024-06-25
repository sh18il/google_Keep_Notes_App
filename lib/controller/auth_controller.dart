import 'package:flutter/material.dart';
import 'package:testfirebase_1/service/auth_service.dart';

class AuthController extends ChangeNotifier {
  AuthService service = AuthService();

  Future<void> signUp(
      BuildContext context, String emailC, String passwordC) async {
    await service.register(context, emailC, passwordC);
    notifyListeners();
  }

  Future<void> login(
      BuildContext context, String emailC, String passwordC) async {
    await service.login(context, emailC, passwordC);
    notifyListeners();
  }

  Future<void> forgotPassword(BuildContext context, String emailC) async {
    await service.forgotPassword(context, emailC);
    notifyListeners();
  }

  Future googleSignUp() async {
    await service.signInWithGoogle();
    notifyListeners();
  }
}
