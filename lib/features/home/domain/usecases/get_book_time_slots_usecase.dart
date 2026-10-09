import 'package:dartz/dartz.dart';
import 'package:new_medicaa/config/erorr/failure.dart';
import 'package:new_medicaa/features/home/domain/repositories/appointment_repository.dart';

class GetBookedTimeSlotsUseCase {
  final AppointmentRepository repository;

  GetBookedTimeSlotsUseCase(this.repository);

  Future<Either<Failure, List<String>>> call({
    required String doctorId,
    required String date,
  }) async {
    return await repository.getBookedTimeSlots(doctorId: doctorId, date: date);
  }
}
