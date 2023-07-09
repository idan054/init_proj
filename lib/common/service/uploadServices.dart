// ignore_for_file: avoid_print, invalid_return_type_for_catch_error

import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors_inverted.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../common/models/user/user_model.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../widgets/clean_snackbar.dart';
import '../../widgets/my_widgets.dart';
import 'package:http/http.dart' as http;

class UploadServices {
  static Future<String?> imgbbUploadPhoto(String base64) async {
    print('START: imgbbUploadPhoto()');
    var response = await http.post(
      Uri.parse('https://api.imgbb.com/1/upload?key=b9333b8a1fc6248d5b2a7f8ef71df84b'),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {"image": base64},
    );
    if (response.statusCode == 200) {
      var displayUrl = json.decode(response.body)['data']['display_url'];
      print('displayUrl $displayUrl');
      return displayUrl;
    } else {
      return null;
    }
  }

  ///Example response (imgbb) :
  /*
  {
  data: {
    id: ZY2KVvx,
    title: 373c56f8816b,
    url_viewer: https: //ibb.co/ZY2KVvx,
    url: https: //i.ibb.co/hZYHyrV/373c56f8816b.jpg,
    display_url: https: //i.ibb.co/hZYHyrV/373c56f8816b.jpg,
    width: 150,
    height: 150,
    size: 11374,
    time: 1675785168,
    expiration: 0,
    image: {
      filename: 373c56f8816b.jpg,
      name: 373c56f8816b,
      mime: image/jpeg,
      extension: jpg,
      url: https: //i.ibb.co/hZYHyrV/373c56f8816b.jpg
    },
    thumb: {
      filename: 373c56f8816b.jpg,
      name: 373c56f8816b,
      mime: image/jpeg,
      extension: jpg,
      url: https: //i.ibb.co/ZY2KVvx/373c56f8816b.jpg
    },
    delete_url: https: //ibb.co/ZY2KVvx/523bd951fe697745b763009836d794c0
  },
  success: true,
  status: 200
}
   */

  //~ Replaced by imgbb API!
  //! READ DESC BELOW
  // because Firebase storage have limit bandwidth of 4000MB a Day.
  // U can also use Hive cache or imgbb alternatives
  static Future<String> fireStorageUploadPhoto(UserModel currUser, File image,
      {required Function(TaskSnapshot) then}) async {
    print('START: uploadProfilePhoto()');
    // rilFlushBar(context, 'Uploading photo...', duration: 2, isShimmer: true);
    // cleanSnack(context, text: 'Update profile photo...', sec: 2, showSnackAction: false);

    var refFile = FirebaseStorage.instance
        .ref()
        // .child('${FirebaseAuth.instance.currentUser?.displayName}_Profile_${DateTime.now()}');
        .child('${currUser.email}_Profile');

    await refFile.putFile(image).then(then).catchError((e) => print('putFile ERR: $e'));

    var imageUrl = await refFile.getDownloadURL();
    print('imageUrl $imageUrl');
    await FirebaseAuth.instance.currentUser?.updatePhotoURL(imageUrl);
    print(
        'FirebaseAuth.instance.currentUser.photoURL ${FirebaseAuth.instance.currentUser?.photoURL}');
    return imageUrl;
  }
}
