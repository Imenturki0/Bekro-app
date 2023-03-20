import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
Future<String> userSetup(String displayName) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Clients');
  FirebaseAuth auth = FirebaseAuth.instance;
  String? uid = auth.currentUser?.uid;
  final newUserRef = await users.add({
    'email': auth.currentUser?.email,
    'is_admin': false,
    'free_whirls_count': 0,
    'full_name': displayName,
    'qr_code': '${generateSessionToken()}user_${uid!}',
    'stars_count': 0,
    'used_cups_count': 0,
    'whirls_count': 0,
    'uid': uid,
  });
  final newDocId = newUserRef.id;
  return newDocId;
}

// Generate random session token
String generateSessionToken() {
  var uuid = const Uuid();
  return uuid.v4(); // generates a random UUID version 4 string
}

// Get UID
Future<String> getCurrentUID() async {
  return (_firebaseAuth.currentUser!).uid;
}

// Get user detail based on doc id
Future<Map<String, dynamic>> getUserData(String? userId) async {
  final CollectionReference collectionRef = FirebaseFirestore.instance.collection('Clients');
  var returnVal;
  try{
    await collectionRef.where('uid', isEqualTo: '$userId').limit(1).get().then((userDetail) {
      if (userDetail.size != 0) {
        returnVal= userDetail.docs.first.data();
      }
    });
  } catch(e){
    throw Exception('User not found!');
  }
  return returnVal;
}

// Get user detail based on field value
Future<dynamic> getUserDetail(String fieldName, String fieldValue) async {
  // Get a reference to the collection you want to query
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('Clients');

  final userDetail = await collectionRef
      .where(fieldName, isEqualTo: fieldValue)
      .limit(1)
      .get();
  if (userDetail.size != 0) {
    return userDetail.docs.first.data()!;
  } else {
    throw Exception('User not found!');
  }
}

bool isUserLogged() {
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  if (firebaseUser != null) {
    return true;
  } else {
    return false;
  }
}

Future<bool> isUserAdmin() async{
  String firebaseUserId = FirebaseAuth.instance.currentUser!.uid;
  final userInfo = await getUserData(firebaseUserId);
  if (userInfo.isNotEmpty) {
    return Future<bool>.value(userInfo['is_admin']);
  }
  return Future<bool>.value(false);
}

