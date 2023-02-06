// ignore_for_file: omit_local_variable_types

import 'dart:convert';
import 'package:example/common/extensions/color_printer.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;

class DynamicLinkService {
  static void initDynamicLinks() async {
    print('START: initDynamicLinks()');
    FirebaseDynamicLinks.instance;
    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    // A listener for link callbacks when the app is in background calling

    FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData data) async {
      // var appModel = Provider.of<AppModel>(context, listen: false);
      // appModel.changeIsLoading(true);
      print('data.asMap() ${data.asMap()}');
      await _handleDynamicLink(data.link.toString());
      // appModel.changeIsLoading(false);
    });

    // the getInitialLink() gets the link that opened the app (or null if it was not opened via a dynamic link)
    final deepLink = data?.link;

    if (deepLink != null) {
      printYellow('[firebase-dynamic-link] getInitialLink: $deepLink');
      await _handleDynamicLink(deepLink.toString());
    }
  }

  //Navigate to ProductDetail screen by entering productURL
  static Future<void> _handleDynamicLink(String productUrl) async {
    print('START: _handleDynamicLink()');
    print('productUrl $productUrl');
    var productId = productUrl.split('?p=').last;
    try {
      // final product = await Services().api.getProductByPermalink(context, productUrl);
      // await Navigator.of(context).pushNamed(
    } catch (err) {
      printYellow('[firebase-dynamic-link] Error: ${err.toString()}');
    }
  }

  static DynamicLinkParameters productParameters({
    required String productUrl,
    required String productId,
  }) {
    print('https://www.spider3d.co.il/?p=$productId');

    return DynamicLinkParameters(
      uriPrefix: 'https://riltopia.page.link',
      link: Uri.parse('https://www.spider3d.co.il/?p=$productId'),
      androidParameters: const AndroidParameters(packageName: 'com.biton.messaging'),
      iosParameters: const IOSParameters(bundleId: 'com.biton.messaging'),
    );
  }

  /// share product link that contains Dynamic link
  static void sharePostLink({
    required String productUrl,
    required String productId,
  }) async {
    var productParams = productParameters(productUrl: productUrl, productId: productId);
    var firebaseDynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(productParams);
    print('firebaseDynamicLink $firebaseDynamicLink');
    await Share.share(firebaseDynamicLink.toString());
    return;
    http.Response response;

    try {
      response = await http.post(Uri.https("api.rebrandly.com", "/v1/links"),
          headers: {
            "apikey": "b4d30300ce9e4a609d7776e4a1df5f8f",
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            'domain': {'id': 'c0f887ba9eb4461cab7d12b714f8644b'},
            'destination': '$firebaseDynamicLink',
            'title': 'product: $productId'
          }));
      printYellow(response.body);
      if (response.statusCode == 200) {
        await Share.share(
          'https://${(jsonDecode(response.body) as Map<String, dynamic>)['shortUrl']}',
        );
      }
    } catch (e) {
      printRed('$e');
      await Share.share(firebaseDynamicLink.toString());
    }
  }
}
