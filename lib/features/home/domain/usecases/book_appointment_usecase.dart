import 'package:dartz/dartz.dart';
import 'package:new_medicaa/config/erorr/failure.dart';
import 'package:new_medicaa/features/home/domain/entities/appointment_entity.dart';
import 'package:new_medicaa/features/home/domain/repositories/appointment_repository.dart';

class BookAppointmentUseCase {
  final AppointmentRepository repository;

  BookAppointmentUseCase(this.repository);

  Future<Either<Failure, void>> call(AppointmentEntity appointment) async {
    return await repository.bookAppointment(appointment);
  }
}
