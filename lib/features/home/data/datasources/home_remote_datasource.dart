import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_medicaa/config/backendpoint.dart';
import 'package:new_medicaa/config/services/databaseservice.dart';
import 'package:new_medicaa/features/home/data/datasources/home_local_datasource.dart';

class HomeRemoteDataSource {
  final Databasabaseservice databaseService;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRemoteDataSource({
    required this.databaseService,
    required this.homeLocalDataSource,
  });
  Future<List<Map<String, dynamic>>> getHomeData() async {
    final data = await databaseService.getCollection(
      collectionPath: BackEndpoint.doctorCollection,
    );
    return data;
  }

  Future<List<Map<String, dynamic>>> getMyAppointment() async {
    final patientProfile = await homeLocalDataSource.getPatientProfile();

    final patientId =
        patientProfile?['uid'] ??
        patientProfile?['uId'] ??
        patientProfile?['PatientId'] ??
        patientProfile?['patientId'] ??
        FirebaseAuth.instance.currentUser?.uid;

    if (patientId == null) {
      throw Exception('User ID not found locally');
    }

    final data = await databaseService.getDataWhere(
      collectionPath: BackEndpoint.appointmentsCollection,
      field: 'patientId',
      isEqualTo: patientId,
    );
    return data;
  }

  Future<List<Map<String, dynamic>>> getDoctorCategory(
    String field,
    String value,
  ) async {
    final data = await databaseService.getDataWhere(
      collectionPath: BackEndpoint.doctorCollection,
      field: field,
      isEqualTo: value,
    );
    return data;
  }
}
