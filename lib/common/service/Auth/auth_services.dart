import 'package:auto_route/auto_route.dart';
import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/user/user_model.dart';
import '../Database/firebase_db.dart' as click;
import '../Database/firebase_db.dart';

class AuthService {
  /// streamUsers() Available At [click.Database] // <<---
  static User? authUser = FirebaseAuth.instance.currentUser;

  /// Google LOGIN
  static Future signInWithGoogle(BuildContext context, {bool signUpScenario = false}) async {
    print('START: signInWithGoogle()');

    // autoLogin for when user casually come back to the app
    if (signUpScenario) {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
    }

    User? googleUser;
    if (authUser?.uid == null || signUpScenario) googleUser = await _googleAuthPopup();
    if (googleUser == null && signUpScenario) return;

    //~ Check if User exist:
    var userEmail = authUser?.uid == null ? googleUser?.email : authUser!.email;
    var userData = await Database.docData('users/$userEmail');

    if (userData == null || userData['tags'] == null) {
      printYellow('START:  New User:');

      // This fix bug when user out while signup.
      if (googleUser?.uid == null) googleUser = await _googleAuthPopup();

      var user = context.uniProvider.currUser.copyWith(
        uid: googleUser!.uid,
        email: googleUser.email,
        // name: googleUser.displayName, // DEFAULT
        // photoUrl: googleUser.photoURL, // DEFAULT
      );
      context.uniProvider.updateUser(user);
      context.router.replace(signUpScenario ? const OnBoardingRoute() : const LoginRoute());
    } else {
      printYellow('START:  Exist User:');
      var currUser = UserModel.fromJson(userData);

      String? fcm = await FirebaseMessaging.instance.getToken();
      print('fcm ${fcm}');
      if (userData['fcm'] != fcm) {
        Database.updateFirestore(
            collection: 'users', docName: userData['email'], toJson: {'fcm': fcm});
        currUser = currUser.copyWith(fcm: fcm);
      }

      context.uniProvider.updateUser(currUser);
      context.router.replace(DashboardRoute());
    }
  }

  // static Future<User?> _setFcm() async {
  //
  // }

  static Future<User?> _googleAuthPopup() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    // Sign in & Create user on firebase console
    final googleAuth = await googleUser.authentication;
    await FirebaseAuth.instance.signInWithCredential(GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken));
    authUser = FirebaseAuth.instance.currentUser;
    return authUser;
  }
}

/// Facebook LOGIN

/*  Future signInWithFacebook(context) async {
    await FirebaseAuth.instance.signOut();

    // Trigger the sign-in flow
    // final loginResult = await FacebookAuth.instance.login(); // login based firebase
    final facebookLogin = FacebookLogin();
    var facebookLoginResult =
        await facebookLogin.logIn(permissions: [
          FacebookPermission.email,
          FacebookPermission.publicProfile,
          FacebookPermission.userBirthday,
        ]);

    // Add it to Firebase auth
    final facebookAuthCredential =
         FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);
    await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    var fireCurrentUser = FirebaseAuth.instance.currentUser;
    await updateUserModel(context, fireCurrentUser, 'Facebook');

  }*/

/*
  Future<void> addUser(String email, String pass, context) async {
    try {
      // var time = DateTime.now();
      await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      // .then((value) => {
      //       FirebaseFirestore.instance
      //           .collection('accounts')
      //           .doc(uid)
      //           .collection('users')
      //           .add({
      //         'email': email,
      //         'password': pass,
      //         'creation': time.toString(),
      //         'id': uid,
      //       })
      //     });
      // await prefs.setString('authToken', uid.toString());
    } catch (e) {
      print('error creating account');
    }
  }
*/

/// Email LOGIN
/*  Future<String> signInWithEmail(
    context, {
    required GlobalKey<FormState> key,
    required String email,
    required bool signup,
    required String pass}) async {


    // SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      key.currentState!.validate();

      signup ? await _auth.createUserWithEmailAndPassword(email: email, password: pass)
      : await _auth.signInWithEmailAndPassword(email: email, password: pass);
      // await _auth.signInWithEmailAndPassword(

      // await prefs.setString('authToken', uid!);

      final fireCurrentUser = FirebaseAuth.instance.currentUser;
      await updateUserModel(context, fireCurrentUser, 'Email');

      return 'Succeed';
    } catch (e) {
        print(e.toString());
      return e.toString();
    }
  }*/

/*  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }*/
