import 'package:auto_route/auto_route.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Auth/firebase_database.dart' as click;
import 'firebase_database.dart';

class AuthService {
  /// streamUsers() Available At [click.Database] // <<---

  static final auth = FirebaseAuth.instance;

  /// Google LOGIN
  Future signInWithGoogle(BuildContext context) async {
    print('START: signInWithGoogle()');
    // if (_auth.currentUser != null && kDebugMode) {
    //   return context.router.replace(const CreateUserRoute());
    // }
    await auth.signOut();
    await GoogleSignIn().signOut();
    final googleUser = await GoogleSignIn().signIn();

    // Sign in & Create user on firebase console
    final googleAuth = await googleUser!.authentication;
    await auth.signInWithCredential(GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken));

    var fireUser = auth.currentUser;
    var user = context.uniProvider.currUser.copyWith(
      uid: fireUser?.uid,
      email: fireUser?.email,
      name: fireUser?.displayName,
      photoUrl: fireUser?.photoURL,
    );
    context.uniProvider.updateUser(user);

    var userFsData = await Database.docData('users/${user.email}');
    userFsData == null ||
            userFsData['age'] == null ||
            userFsData['birthdayStr'] == null
        ? context.router.replace(const CreateUserRoute())
        : context.router.replace(const ChatsListRoute());

    print('userFsData $userFsData');
    print(
        'context.uniProvider.currUser.photoUrl ${context.uniProvider.currUser.photoUrl}');
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
