import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{
  Future addUser (String userId, Map<String, dynamic> userInfoMap){
    return FirebaseFirestore.instance.collection("Users").doc(userId).set(userInfoMap);
  }
}