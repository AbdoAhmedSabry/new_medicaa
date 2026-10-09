import 'dart:convert';

import 'package:new_medicaa/config/backendpoint.dart';
import 'package:new_medicaa/config/cachehelper.dart';

abstract class ProfileLocalDataSource {
  Future<Map<String, dynamic>?> getPatientProfile();
  Future<void> deletLocalData();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  @override
  Future<Map<String, dynamic>?> getPatientProfile() async {
    final jsonString = CacheHelper.getData(key: CacheEndpoint.patientProfile);
    if (jsonString != null && jsonString is String && jsonString.isNotEmpty) {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }

  @override
  Future<void> deletLocalData() async {
    await CacheHelper.removeData(key: CacheEndpoint.patientProfile);
  }
}
