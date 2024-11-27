import 'package:board_client/data/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import '../../generated/user.pbgrpc.dart' as grpc;

class AuthService {
  final BuildContext context;
  final FirebaseAuth auth = FirebaseAuth.instance;

  AuthService(this.context);

  Future<void> verifyPhone(grpc.User newUser) async {
    await auth.verifyPhoneNumber(
      phoneNumber: newUser.phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        GetIt.I<UserService>().endIfPhoneValid(newUser);
      },
      verificationFailed: (FirebaseAuthException error) {
        if (error.code == 'invalid-phone-number') {
          print('The provided phone number is not valid: ${newUser.phone}');
        }
        throw Exception(error);
      },
      codeSent: (String verificationId, int? forceResendingToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
