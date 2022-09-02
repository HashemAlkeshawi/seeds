import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class Firebase_Helper {
  Firebase_Helper._();

  static Firebase_Helper firebase_helper = Firebase_Helper._();

  FirebaseAuth auth = FirebaseAuth.instance;

  verifyPhoneNumber() async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+972592103756',
      verificationCompleted: (PhoneAuthCredential credential) async {
        log('completed');
        await auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('timout');
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        log('sent');
      },
      verificationFailed: (FirebaseAuthException error) {
        log('faild');
      },
    );
  }
}
