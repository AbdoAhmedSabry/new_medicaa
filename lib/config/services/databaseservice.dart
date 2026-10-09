import 'package:cloud_firestore/cloud_firestore.dart';

class Databasabaseservice {
  final FirebaseFirestore firestoreService;

  Databasabaseservice({required this.firestoreService});
  Future<Map<String, dynamic>?> getData({
    required String collectionPath,
    required String docId,
  }) async {
    final doc = await firestoreService
        .collection(collectionPath)
        .doc(docId)
        .get();
    return doc.data();
  }

  Future<List<Map<String, dynamic>>> getCollection({
    required String collectionPath,
  }) async {
    final querySnapshot = await firestoreService
        .collection(collectionPath)
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();

      data['id'] = doc.id;

      return data;
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getDataWhere({
    required String collectionPath,
    required String field,
    required dynamic isEqualTo,
  }) async {
    final querySnapshot = await firestoreService
        .collection(collectionPath)
        .where(field, isEqualTo: isEqualTo)
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  Future<void> setData({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await firestoreService.collection(collectionPath).doc(docId).set(data);
  }

  Future<void> updateData({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await firestoreService.collection(collectionPath).doc(docId).update(data);
  }

  Future<void> deleteData({
    required String collectionPath,
    required String docId,
  }) async {
    await firestoreService.collection(collectionPath).doc(docId).delete();
  }
}
