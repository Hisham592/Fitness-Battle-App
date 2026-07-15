import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voz_app/features/onboarding_auth/data/models/user_model.dart';
import 'package:voz_app/features/onboarding_auth/data/services/auth_firebase_service.dart';
import 'package:voz_app/features/onboarding_auth/logic/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthFirebaseService _authFirebaseService;
  AuthCubit(this._authFirebaseService) : super(AuthInitial());

  String? _tempName;
  String? _tempEmail;
  String? _tempPassword;

  void saveTempCredentials({
    required String name,
    required String email,
    required String password,
  }) {
    _tempName = name;
    _tempEmail = email;
    _tempPassword = password;
  }

  Future<void> registerAndSaveUser({required String selectedLevel}) async {
    if (_tempName == null || _tempEmail == null || _tempPassword == null) {
      emit(AuthFailur(message: 'Missing required information'));
      return;
    }

    emit(AuthLoading());

    try {
      final user = await _authFirebaseService.signUpWithEmailAndPassword(
        email: _tempEmail!,
        password: _tempPassword!,
      );
      if (user != null) {
        final userModel = UserModel(
          uid: user.uid,
          name: _tempName!,
          email: _tempEmail!,
          level: selectedLevel,
        );

        await _authFirebaseService.saveUserData(userModel);
        emit(AuthSuccess());
      } else {
        emit(AuthFailur(message: 'User creation failed'));
      }
    } catch (e) {
      emit(AuthFailur(message: e.toString()));
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final user = await _authFirebaseService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailur(message: 'Login failed'));
      }
    } catch (e) {
      emit(AuthFailur(message: e.toString()));
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(AuthLoading());
    try {
      await _authFirebaseService.sendPasswordResetEmail(email: email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailur(message: e.toString()));
    }
  }
}
