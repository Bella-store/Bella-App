import 'package:bella_app/models/user_model.dart';
import 'package:bloc/bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  Future<void> loadUserProfile() async {
    emit(EditProfileLoading());
    try {
      final userModel = await UserModel.loadFromPreferences();
      if (userModel != null) {
        emit(EditProfileLoaded(userModel));
      } else {
        emit(EditProfileError('Failed to load user data.'));
      }
    } catch (e) {
      emit(EditProfileError('Failed to load user data.'));
    }
  }

  Future<void> updateUserProfile(UserModel updatedUser) async {
    emit(EditProfileLoading());
    try {
      // Save to Firebase
      await FirebaseFirestore.instance
          .collection('users')
          .doc(updatedUser.userId)
          .update(updatedUser.toMap());

      // Save to SharedPreferences
      await updatedUser.saveToPreferences();

      emit(EditProfileLoaded(updatedUser));
    } catch (e) {
      emit(EditProfileError('Failed to update user data.'));
    }
  }
}
