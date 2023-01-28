import 'package:auto_route/auto_route.dart';
import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io' show Platform;
import '../../models/user/user_model.dart';
import '../../providers/firebase_options.dart';
import '../Database/firebase_db.dart' as click;
import '../Database/firebase_db.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:apple_sign_in/apple_sign_in.dart' as apl;

class AuthService {
  /// streamUsers() Available At [click.Database] // <<---
  static var auth = FirebaseAuth.instance;
  static User? authUser = FirebaseAuth.instance.currentUser;

  /// Google LOGIN
  static Future signInWith(BuildContext context,
      {required bool autoSignIn, bool applePopup = false}) async {
    print('START: signInWith()');
    // User? userProvider;

    // autoLogin for when user casually come back to the app
    if (!autoSignIn) {
      await FirebaseAuth.instance.signOut();
      if (!applePopup) await GoogleSignIn().signOut();
    }

    // When try to auto signing but got issues
    if ((authUser?.uid == null || authUser?.email == null) && autoSignIn) {
      await FirebaseAuth.instance.signOut();
      context.router.replace(const LoginRoute());
      return;
    }

    if (!autoSignIn) {
      // userProvider = await // No need
      await (applePopup ? _appleAuthPopup() : _googleAuthPopup());
    }

    // While signing from Login page
    if ((authUser == null || authUser?.uid == null || authUser?.email == null) && !autoSignIn) {
      return;
    }

    //~ Check if User exist:
    var userEmail = authUser!.email;
    var userData = await Database.docData('users/$userEmail');

    if (userData == null || userData['tags'] == null) {
      printYellow('START User: New');

      // This fix bug when user out while signup. // BETA COMMENT
      // if (authUser == null || authUser?.uid == null || authUser?.email == null) {
      //   authUser = await (applePopup ? _appleAuthPopup() : _googleAuthPopup());
      // }

      var user = context.uniProvider.currUser.copyWith(
        uid: authUser!.uid,
        email: authUser!.email,
        // name: userProvider.displayName, // DEFAULT
        // photoUrl: userProvider.photoURL, // DEFAULT
      );
      context.uniProvider.updateUser(user);
      context.router.replace(const OnBoardingRoute());
    } else {
      printYellow('START User: Exist');
      var currUser = UserModel.fromJson(userData);

      String? fcm = await FirebaseMessaging.instance.getToken();
      // print('fcm $fcm');
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
    print('START: _googleAuthPopup()');
    final googleUser = await GoogleSignIn(
            clientId: Platform.isIOS
                ? DefaultFirebaseOptions.currentPlatform.iosClientId
                : DefaultFirebaseOptions.currentPlatform.androidClientId)
        .signIn();
    if (googleUser == null) return null;

    // Sign in & Create user on firebase console
    final googleAuth = await googleUser.authentication;
    await FirebaseAuth.instance.signInWithCredential(GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken));
    authUser = FirebaseAuth.instance.currentUser;
    print('authUser $authUser');
    return authUser;
  }

  // Future<User?> signInWithApple() async {
  //   final AuthorizationResult result = await AppleSignIn.performRequests([
  //     const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
  //   ]);
  //
  //       final AppleIdCredential appleIdCredential = result.credential;
  //
  //       OAuthProvider oAuthProvider =
  //       OAuthProvider("apple.com");
  //       // oAuthProvider.setScopes(scopes)
  //
  // }

  /// Apple LOGIN
  static Future<User?> _appleAuthPopup() async {
    print('START: _appleAuthPopup()');
    // 1. perform the sign-in request

    // final apl.AuthorizationResult result = await
    // apl.AppleSignIn.performRequests([
    //   const apl.AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    // ]);

    final appleProvider = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // 2. check the result
    final credential = OAuthProvider('apple.com').credential(
        idToken: appleProvider.identityToken, accessToken: appleProvider.authorizationCode);
    final authSign = await auth.signInWithCredential(credential);
    final firebaseUser = authSign.user;
    if (firebaseUser != null && firebaseUser.email == null) {
      var mail = '${firebaseUser.uid.substring(0, 10)}@apple.com';
      firebaseUser.updateEmail(mail);
    }
    return firebaseUser;
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
