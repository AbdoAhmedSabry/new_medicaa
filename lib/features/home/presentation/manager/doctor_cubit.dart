import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_medicaa/features/home/domain/usecases/get_doctors_by_category_use_case.dart';
import 'package:new_medicaa/features/home/presentation/manager/doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final GetDoctorsByCategoryUseCase getDoctorsByCategoryUseCase;

  DoctorCubit({required this.getDoctorsByCategoryUseCase})
      : super(DoctorInitial());

  Future<void> getDoctorsByCategory({
    required String field,
    required String value,
  }) async {
    emit(DoctorLoading());

    final result = await getDoctorsByCategoryUseCase(field, value);

    result.fold(
      (failure) => emit(DoctorError(failure.message)),
      (doctors) => emit(DoctorSuccess(doctors)),
    );
  }
}
