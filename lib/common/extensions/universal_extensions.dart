import 'package:flutter/material.dart';


// Provider models shortcuts
// UserModel kUserModel(context, {bool listen = false})
// => Provider.of<UserModel>(context, listen: listen);
// UniModel kUniModel(context, {bool listen = false})
// => Provider.of<UniModel>(context, listen: listen);


// Smart navigation shortcuts
Future<dynamic> kPushNavigator(context, screen,{bool replace = false}) =>
    replace ?
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => screen))
        : Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => screen));