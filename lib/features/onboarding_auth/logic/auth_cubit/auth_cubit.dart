import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voz_app/features/onboarding_auth/data/models/user_model.dart';
import 'package:voz_app/features/onboarding_auth/data/services/auth_firebase_service.dart';
import 'package:voz_app/features/onboarding_auth/logic/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthFirebaseService _authFirebaseService;
  AuthCubit(this._authFirebaseService) : super(AuthInitial());

  String? _tempEmail;
  String? _tempPassword;

  void saveTempCredentials({required String email, required String password}) {
    _tempEmail = email;
    _tempPassword = password;
  }

  Future<void> registerAndSaveUser({required String selectedLevel}) async {
    if (_tempEmail == null || _tempPassword == null) {
      emit(AuthFailur(message: 'Missing Email or Password'));
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
}
