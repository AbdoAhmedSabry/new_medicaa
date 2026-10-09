import 'package:dartz/dartz.dart';
import 'package:new_medicaa/config/erorr/failure.dart';
import 'package:new_medicaa/features/home/domain/entities/appointment_entity.dart';
import 'package:new_medicaa/features/home/domain/repositories/appointment_repository.dart';

class GetMyAppointmentUseCase {
  final AppointmentRepository appointmentRepository;

  GetMyAppointmentUseCase(this.appointmentRepository);

  Future<Either<Failure, List<AppointmentEntity>>> call() async {
    return await appointmentRepository.getMyAppointment();
  }
}
