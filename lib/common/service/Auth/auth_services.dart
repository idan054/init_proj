import 'package:auto_route/auto_route.dart';
import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/user/user_model.dart';
import '../Database/firebase_database.dart' as click;
import '../Database/firebase_database.dart';

class AuthService {
  /// streamUsers() Available At [click.Database] // <<---
  static User? authUser = FirebaseAuth.instance.currentUser;

  /// Google LOGIN
  static Future signInWithGoogle(BuildContext context, {alsoSignOut = false}) async {
    print('START: signInWithGoogle()');

    // When signInWithGoogle Button Clicked.
    if (alsoSignOut) {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
    }

    User? googleUser;
    if (authUser?.uid == null || alsoSignOut) googleUser = await googleAuthAction;

    //~ Check if User exist:
    var userEmail = authUser?.uid == null ? googleUser!.email : authUser!.email;
    print('userEmail $userEmail');
    var userData = await Database.docData('users/$userEmail');
    // print('userData $userData');
    if (userData == null ||
        userData['gender'] == null ||
        userData['age'] == null ||
        userData['birthday'] == null) {
      print('START:  New User:()');
      //~ New User:
      // This fix bug when user out while signup.
      if (googleUser?.uid == null) googleUser = await googleAuthAction;

      var user = context.uniProvider.currUser.copyWith(
        uid: googleUser!.uid,
        email: googleUser.email,
        name: googleUser.displayName,
        photoUrl: googleUser.photoURL,
      );
      context.uniProvider.updateUser(user);
      context.router.replace(const CreateUserRoute());
    } else {
      //~ Exist User:
      print('START:  Exist User:()');
      var currUser = UserModel.fromJson(userData);
      context.uniProvider.updateUser(currUser);
      context.router.replace(DashboardRoute());
    }
  }

  static Future<User?> get googleAuthAction async {
    final googleUser = await GoogleSignIn().signIn();

    // Sign in & Create user on firebase console
    final googleAuth = await googleUser!.authentication;
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
