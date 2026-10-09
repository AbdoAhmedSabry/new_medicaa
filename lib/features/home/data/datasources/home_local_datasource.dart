import 'dart:convert';

import 'package:new_medicaa/config/backendpoint.dart';
import 'package:new_medicaa/config/cachehelper.dart';

abstract class HomeLocalDataSource {
  Future<Map<String, dynamic>?> getPatientProfile();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<Map<String, dynamic>?> getPatientProfile() async {
    final jsonString = CacheHelper.getData(key: CacheEndpoint.patientProfile);

    if (jsonString != null && jsonString is String && jsonString.isNotEmpty) {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    }

    return null;
  }
}
