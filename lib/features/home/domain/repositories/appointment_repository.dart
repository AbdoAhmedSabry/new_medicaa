import 'package:dartz/dartz.dart';
import 'package:new_medicaa/config/erorr/failure.dart';
import 'package:new_medicaa/features/home/domain/entities/appointment_entity.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, void>> bookAppointment(AppointmentEntity appointment);
  Future<Either<Failure, List<String>>> getBookedTimeSlots({
    required String date,
    required String doctorId,
  });
  Future<Either<Failure, List<AppointmentEntity>>> getMyAppointment();
}
