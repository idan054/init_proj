import 'dart:convert';

import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/profile/user_model.dart';
import 'package:example/screens/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io' show Platform;
import '../extensions/universal_extensions.dart';
import 'location_service.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

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

  /// Google LOGIN
  Future signInWithGoogle(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    final googleUser = await GoogleSignIn().signIn();

    // Sign in & Create user on firebase console
    final googleAuth = await googleUser!.authentication;
    await FirebaseAuth.instance.signInWithCredential(
        GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken));

    var fireUser = FirebaseAuth.instance.currentUser;
    var user = UserModel(
      uid: fireUser?.uid,
      email: fireUser?.email,
      name: fireUser?.displayName,
      photoUrl: fireUser?.photoURL,
    );

    context.uniModel.updateUser(user);
    // await getLocation(); // also set in Provider
    context.navigateTo(const HomePage());
  }

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

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
