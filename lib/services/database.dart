// ignore_for_file: await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("DuitKu")
        .doc(id)
        .set(employeeInfoMap);
  }

  Future<Stream<QuerySnapshot>> getEmployeeDetails(
      {required String category}) async {
    return FirebaseFirestore.instance
        .collection("DuitKu")
        .where("Category", isEqualTo: category)
        .snapshots();
  }

  Future updateEmployeeDetails(
      String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("DuitKu")
        .doc(id)
        .update(updateInfo);
  }

  Future deleteEmployeeDetails(String id) async {
    return await FirebaseFirestore.instance
        .collection("DuitKu")
        .doc(id)
        .delete();
  }
}
