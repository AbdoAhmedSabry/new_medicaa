import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:new_medicaa/config/backendpoint.dart';
import 'package:new_medicaa/config/erorr/failure.dart';
import 'package:new_medicaa/features/home/data/datasources/home_remote_datasource.dart';
import 'package:new_medicaa/features/home/data/models/appointment_model.dart';
import 'package:new_medicaa/features/home/domain/entities/appointment_entity.dart';
import 'package:new_medicaa/features/home/domain/repositories/appointment_repository.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final FirebaseFirestore firestore;
  final HomeRemoteDataSource homeRemoteDataSource;
  AppointmentRepositoryImpl(this.firestore, this.homeRemoteDataSource);

  @override
  Future<Either<Failure, void>> bookAppointment(
    AppointmentEntity appointment,
  ) async {
    try {
      final doctorDoc = await firestore
          .collection('doctors')
          .doc(appointment.DoctorId)
          .get();

      if (!doctorDoc.exists) {
        return Left(ServerFailure('Doctor data not found'));
      }

      final doctorData = doctorDoc.data()!;
      double calculatedPrice = 0.0;

      if (appointment.consultationType.toLowerCase().contains('online')) {
        calculatedPrice = (doctorData['onlinePrice'] ?? 0).toDouble();
      } else {
        calculatedPrice = (doctorData['clinicPrice'] ?? 0).toDouble();
      }

      final batch = firestore.batch();
      final appointmentData = AppointmentModel(
        AppointmentId: appointment.AppointmentId,
        PatientId: appointment.PatientId,
        DoctorId: appointment.DoctorId,
        date: appointment.date,
        time: appointment.time,
        status: appointment.status,
        consultationType: appointment.consultationType,
        doctorName: appointment.doctorName,
        speciality: appointment.speciality,
        doctorImage: appointment.doctorImage,
        patientName: appointment.patientName,
        patientImage: appointment.patientImage,
        patientPhone: appointment.patientPhone,
      ).toJson();

      final appointmentRef = firestore
          .collection(BackEndpoint.appointmentsCollection)
          .doc(appointmentData['AppointmentId']);

      batch.set(appointmentRef, appointmentData);

      final transactionRef = firestore.collection('transactions').doc();
      final transactionData = {
        'id': transactionRef.id,
        'doctorId': appointment.DoctorId,
        'date': appointment.date,
        'patientName': appointment.patientName,
        'serviceType': appointment.consultationType,
        'amount': calculatedPrice,
        'status': 'completed',
      };

      batch.set(transactionRef, transactionData);

      await batch.commit();

      return Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to book appointment'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getBookedTimeSlots({
    required String date,
    required String doctorId,
  }) async {
    try {
      final snapshot = await firestore
          .collection(BackEndpoint.appointmentsCollection)
          .where('date', isEqualTo: date)
          .where('doctorId', isEqualTo: doctorId)
          .where('status', whereIn: ['booked', 'pending'])
          .get();
      final bookedTimeSlots = snapshot.docs
          .map((doc) => doc['time'] as String)
          .toList();
      return Right(bookedTimeSlots);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch booked time slots'));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getMyAppointment() async {
    try {
      final data = await homeRemoteDataSource.getMyAppointment();
      final appointments = data
          .map((json) => AppointmentModel.fromJson(json))
          .toList();
      return right(appointments);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
