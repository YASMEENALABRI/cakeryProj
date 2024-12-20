import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  static Future<bool> authenticateUser(
      String name, String password) async {
    DatabaseEvent event = await FirebaseDatabase.instance.ref('user').orderByChild('name').equalTo(name).once();

    if (event.snapshot.exists) {
      Map<dynamic, dynamic> user =
      event.snapshot.value as Map<dynamic, dynamic>;
      for (var key in user.keys) {
        var userData = user[key];
        if (userData['password'] == password) {
          return true; // Login successful
        }
      }
    }
    return false; // Login failed
  }
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

 ////////Adds
  Future<void> adduser(Map<String, dynamic> userData) async {
    await _db.child('user').push().set(userData);
  }
  ////// Retrieves
  Stream<List<Map<String, dynamic>>> getUser() {
    return _db.child('user').onValue.map((event) {
      Map<dynamic, dynamic> userData = event.snapshot.value as Map<dynamic, dynamic> ?? {};
      List<Map<String, dynamic>> userList = [];
      userData.forEach((key, value) {
        Map<String, dynamic> user = Map<String, dynamic>.from(value as Map);
        user['id'] = key; // Save the Firebase key as 'id'
        userList.add(user);
      });
      return userList;
    });
  }
  ////// Updates
  Future<void> updateUser(String id, Map<String, dynamic> userData) async {
    await _db.child('user').child(id).update(userData);
  }
///////Deletes
  Future<void> deleteUser(String id) async {
    await _db.child('user').child(id).remove();
  }

  static sendPasswordResetEmail(String email) {}
}
