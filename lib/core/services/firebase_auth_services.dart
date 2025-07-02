import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///------------------------------------------------------------------------ إنشاء مستخدم جديد
  Future<String> createNewUser(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String userId = credential.user!.uid;

      // حفظ بيانات المستخدم في Firestore
      await _firestore.collection('Users').doc(userId).set({
        'email': email,
        'userId': userId,
        'lastLogin': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // حفظ FCM Token
      await saveTokenToDatabase(userId);

      return userId;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        throw Exception('The email address is not valid.');
      } else {
        throw Exception(e.message ?? 'Failed to create user.');
      }
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  //--------------------------------------------------------------- تسجيل دخول المستخدم
  Future<User> signInUser(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;

      // تحديث بيانات المستخدم عند تسجيل الدخول
      await _firestore.collection('Users').doc(user.uid).set({
        'email': user.email,
        'userId': user.uid,
        'lastLogin': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // حفظ FCM Token
      await saveTokenToDatabase(user.uid);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        throw Exception('The email address is not valid.');
      } else {
        throw Exception(e.message ?? 'Failed to sign in user.');
      }
    } catch (e) {
      throw Exception('Failed to sign in user: $e');
    }
  }

//---------------------------------------------------------------------------------------------------
  /// إعادة تعيين كلمة المرور
  Future<bool> forgetPasswordService(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'invalid-email') {
        throw Exception('The email address is not valid.');
      } else {
        throw Exception(e.message ?? 'Failed to send password reset email.');
      }
    } catch (e) {
      throw Exception('Failed to send password reset email: $e');
    }
  }

  /// ----------------------------------------------------------------------------------------------التحقق مما إذا كان المستخدم مسجل دخول
  Future<bool> isLoggedIn() async {
    try {
      final user = _auth.currentUser;
      return user != null;
    } catch (e) {
      print("Error checking login status: $e");
      return false;
    }
  }

  /// حفظ FCM Token في Firestore
  Future<void> saveTokenToDatabase(String userId) async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _firestore.collection('Users').doc(userId).update({
        'fcmToken': token,
      });
    }
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('Users').doc(userId).get();

      print("Snapshot exists: ${snapshot.exists}");
      print("Raw Snapshot Data: ${snapshot.data()}");

      if (snapshot.exists) {
        var data = snapshot.data();

        if (data is Map<String, dynamic>) {
          print("User Data: $data");
          return data;
        } else if (data is List<dynamic> && data.isNotEmpty) {
          print("User Data is a List, extracting first element...");
          return data.first as Map<String,
              dynamic>; // تحويل العنصر الأول إلى Map<String, dynamic>
        } else {
          print("Unexpected data format.");
          return null;
        }
      } else {
        print("No data found for userId: $userId");
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      throw Exception('Failed to fetch user data: $e');
    }
  }

  Future<void> logout() async {
    // Store the current user ID before logging out
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last_user_id', currentUser.uid);
    }

    // Sign out from Firebase
    await _auth.signOut();
  }
}
