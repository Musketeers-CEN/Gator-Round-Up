import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class GatorRoundUpFirebaseUser {
  GatorRoundUpFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

GatorRoundUpFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<GatorRoundUpFirebaseUser> gatorRoundUpFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<GatorRoundUpFirebaseUser>(
      (user) {
        currentUser = GatorRoundUpFirebaseUser(user);
        return currentUser!;
      },
    );
