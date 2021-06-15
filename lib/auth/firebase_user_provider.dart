import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ProjectFreeFirebaseUser {
  ProjectFreeFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

ProjectFreeFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ProjectFreeFirebaseUser> projectFreeFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<ProjectFreeFirebaseUser>(
        (user) => currentUser = ProjectFreeFirebaseUser(user));
