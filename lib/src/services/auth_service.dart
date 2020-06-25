
import 'package:moto_maintenance/src/models/user.dart';

abstract class AuthService {
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<User> currentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  // Future<User> signInWithGoogle();
  // Future<User> signInWithFacebook();
  Future<void> sendPasswordResetEmail(String email);
  signOut();
  Stream<User> get onAuthStateChanged;
  void dispose();
}