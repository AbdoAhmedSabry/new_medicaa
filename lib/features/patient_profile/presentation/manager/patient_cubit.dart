import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_medicaa/config/backendpoint.dart';
import 'package:new_medicaa/config/cachehelper.dart';
import 'package:new_medicaa/features/auth/data/models/user_model.dart';
import 'package:new_medicaa/features/patient_profile/data/models/patient_model.dart';
import 'package:new_medicaa/features/patient_profile/domain/repositories/patient_repo.dart';
import 'package:new_medicaa/features/patient_profile/presentation/manager/patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  final PatientRepo patientRepo;
  PatientCubit(this.patientRepo) : super(PatientIntial());
  Future<void> savePatientData({
    required UserModel userModel,
    required double weight,
    required double height,
    required String bloodType,
    required bool hasBloodPressure,
    required bool hasDiabetes,
    required List<String> chronicDiseases,
    required String gender,
    required int age,
  }) async {
    emit(PatientLoading());

    final updatedPatientModel = PatientModel(
      uid: userModel.uid,
      name: userModel.name,
      email: userModel.email,
      phone: userModel.phone,
      weight: weight,
      height: height,
      bloodType: bloodType,
      hasBloodPressure: hasBloodPressure,
      hasDiabetes: hasDiabetes,
      chronicDiseases: chronicDiseases,
      gender: gender,
      age: age,
    );

    var updateResult = await patientRepo.updatePatient(
      patientEntity: updatedPatientModel,
    );

    updateResult.fold(
      (failure) {
        emit(PatientError(errorMessage: failure.message));
      },
      (r) async {
        try {
          await CacheHelper.saveData(
            key: CacheEndpoint.patientProfile,
            value: jsonEncode(
              updatedPatientModel.toJson(),
            ), 
          );

          await CacheHelper.saveData(key: 'isLoggedIn', value: true);

          emit(PatientSuccess(patientModel: updatedPatientModel));
        } catch (e) {
          emit(
            PatientError(
              errorMessage:
                  "حدث خطأ أثناء حفظ البيانات محلياً: ${e.toString()}",
            ),
          );
        }
      },
    );
  }

  Future<void> getPatientData() async {
    emit(PatientLoading());
    var result = await patientRepo.getPatientData();
    result.fold(
      (failure) => emit(PatientError(errorMessage: failure.message)),
      (r) =>
          emit(PatientSuccess(patientModel: PatientModel.fromPatientEntity(r))),
    );
  }

  Future<void> logOut() async {
    emit(PatientLoading());
    final result = await patientRepo.logOut();

    result.fold(
      (failure) => emit(PatientError(errorMessage: failure.message)),
      (_) => emit(PatientLoggedOutSuccess()), 
    );
  }

  Future<void> deletAccount({required String id}) async {
    emit(PatientLoading());
    final result = await patientRepo.deletAccount(id: id);

    result.fold(
      (failure) => emit(PatientError(errorMessage: failure.message)),
      (_) => emit(PatientAccountDeletedSuccess()), 
    );
  }
}
