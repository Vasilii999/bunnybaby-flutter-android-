import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:figma21/models/user_profile.dart';

class ProfileCubit extends Cubit<UserProfile?> {
  ProfileCubit() : super(null);

  void setProfile(UserProfile profile) {
    emit(profile);
  }

  void updateName({required String name}) {
    if (state != null) {
      emit(state!.copyWith(name: name));
      _saveToFirestore(state!);
    }
  }

  void updateAvatar(String url) {
    if (state != null) {
      emit(state!.copyWith(avatarUrl: url));
      _saveToFirestore(state!);
    }
  }

  void clearProfile() {
    emit(null);
  }

  void updateGender(String gender) {
    if (state != null) {
      emit(state!.copyWith(gender: gender));
      _saveToFirestore(state!);
    }
  }

  void updateEmail(String email) {
    if (state != null) {
      emit(state!.copyWith(email: email));
      _saveToFirestore(state!);
    }
  }

  void updateBirthday(DateTime birthday) {
    if (state != null) {
      emit(state!.copyWith(birthday: birthday));
      _saveToFirestore(state!);
    }
  }

  void updatePhone(String phone) {
    if (state != null) {
      emit(state!.copyWith(phone: phone));
      _saveToFirestore(state!);
    }
  }

  void _saveToFirestore(UserProfile profile) {
    FirebaseFirestore.instance.collection('users').doc(profile.id).set(profile.toMap());
  }




}
