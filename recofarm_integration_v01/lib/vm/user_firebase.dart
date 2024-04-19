import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirebase {

  Stream<QuerySnapshot<Map<String, dynamic>>> selectUserEqaulPhone(String phone) {
    return FirebaseFirestore.instance.collection('user').where('phone', isEqualTo: phone).snapshots();
  }

}