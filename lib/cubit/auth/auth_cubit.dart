import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma21/cubit/profile/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';
import '../../models/user_profile.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  AuthCubit() : super(AuthInitial());

  Future<void> sendCode(String phoneNumber) async {
    emit(AuthLoading());
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        emit(AuthSuccess());
      },
      verificationFailed: (FirebaseAuthException e) {
        emit(AuthFailure(e.message ?? 'Ошибка'));
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        emit(AuthCodeSent());
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  Future<void> verifyCodeForLogin({
    required String smsCode,
    required String phone,
  }) async {
    try {
      emit(AuthLoading());
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      await _auth.signInWithCredential(credential);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure('Неверный код или ошибка'));
    }
  }

  Future<void> verifyCodeForRegistration({
    required String smsCode,
    required String name,
    required String email,
    required String phone,
    required String gender,
    DateTime? birthday,
    String? avatarUrl,
  }) async {
    try {
      emit(AuthLoading());

      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final uid = userCredential.user?.uid;

      if (uid != null) {
        final userProfile = UserProfile(
          id: uid,
          name: name,
          email: email,
          phone: phone,
          gender: gender,
          birthday: birthday,
          avatarUrl: avatarUrl,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set(userProfile.toMap());
      }

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure('Неверный код или ошибка'));
    }
  }



  Future<void> fetchProfileAfterAuth(ProfileCubit profileCubit) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        final userProfile = UserProfile.fromMap(doc.data()!);
        profileCubit.setProfile(userProfile);
      }
    }
  }

}




