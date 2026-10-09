import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_medicaa/features/home/domain/entities/home_entity.dart';
import 'package:new_medicaa/features/home/domain/usecases/get_doctors_usecase.dart';
import 'package:new_medicaa/features/home/domain/usecases/get_patient_data_usecase.dart';
import 'package:new_medicaa/features/home/presentation/manager/home_state.dart';
import 'package:new_medicaa/features/patient_profile/domain/entities/patient_entity.dart';

class HomeCubit extends Cubit<Homestate> {
  final GetDoctorsUseCase getDoctorsUseCase;
  final GetPatientDataUseCase getPatientDataUseCase;
  // final GetDoctorsByCategoryUseCase getDoctorsByCategoryUseCase;

  HomeCubit({
    required this.getDoctorsUseCase,
    required this.getPatientDataUseCase,
    // required this.getDoctorsByCategoryUseCase,
  }) : super(HomeInitial());

  Future<void> getHomeData() async {
    emit(HomeLoading());

    List<DoctorEntity> doctorsList = [];
    PatientEntity? currentPatient;
    String? errorMessage;

    final doctorsResult = await getDoctorsUseCase();
    doctorsResult.fold(
      (failure) => errorMessage = failure.message,
      (doctors) => doctorsList = doctors,
    );

    if (errorMessage != null) {
      emit(HomeError(errorMessage!));
      return;
    }

    final patientResult = await getPatientDataUseCase();
    patientResult.fold(
      (failure) => errorMessage = failure.message,
      (patient) => currentPatient = patient,
    );

    if (errorMessage != null) {
      emit(HomeError(errorMessage!));
      return;
    }

    emit(HomeSuccess(doctors: doctorsList, patientData: currentPatient!));
  }

  // Future<void> getDoctorsByCategory(String category) async {
  //   emit(GetDoctorsByCategoryLoading());

  //   final doctorsResult = await getDoctorsByCategoryUseCase('specialty',category);
  //   doctorsResult.fold(
  //     (failure) => emit(GetDoctorsByCategoryError(failure.message)),
  //     (doctors) => emit(GetDoctorsByCategorySuccess(doctors: doctors)),
  //   );
  // }
}
