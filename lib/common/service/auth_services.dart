/*
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:example/common/classes/profile.dart';
import 'package:example/common/models/userModel.dart';
import 'package:example/common/models/userModel.dart';
import 'package:example/common/models/userModel.dart';
import 'package:example/common/models/userModel.dart';
import 'package:example/common/models/userModel.dart';
import 'package:example/common/theme/constants.dart';
import 'package:example/common/classes/rilUser.dart';

import 'package:http/http.dart' as http;
import 'package:example/screens/feedScreen/feed_screen.dart';
import 'dart:io' show Platform;

import 'location_service.dart';


class AuthService {

  final _auth = FirebaseAuth.instance;

  Future signInWithFacebook(context) async {
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

  }

  /// Google LOGIN
  Future signInWithGoogle(context) async {
    await FirebaseAuth.instance.signOut();
    // await GoogleSignIn().signOut();

  // Future<UserCredential?> signInWithGoogle(BuildContext context) async {
  // Future<User?> signInWithGoogle(context) async {
    final googleUser = await GoogleSignIn().signIn();

    // Sign in & Create user on firebase console
    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken );
    await FirebaseAuth.instance.signInWithCredential(credential);
    var fireCurrentUser = FirebaseAuth.instance.currentUser;

    await updateUserModel(context, fireCurrentUser, 'Google');

    // await getCountry(context); // also set in Provider
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
  Future<String> signInWithEmail(
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
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {

    await _auth.sendPasswordResetEmail(email: email);
  }


  Future<void> updateUserModel(
      context, User? fireCurrentUser,
      String loginType) async {

    var _profile = Profile(
          name: fireCurrentUser?.displayName,
          email: fireCurrentUser?.email,
          uid: fireCurrentUser?.uid,
          photoUrl: fireCurrentUser?.photoURL,
    );
    kUserModel(context).updateProfile(_profile);

    var _user = RilUser(
              loggedIn: true,
              loginType: loginType
        );
    kUserModel(context).updateUser(_user);

    await getLocation(context); // also update location in Provider
    kPushNavigator(context, const FeedScreen(), replace: true);
  }
}*/
