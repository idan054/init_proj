// ignore_for_file: omit_local_variable_types

import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;

import '../Feed/feed_services.dart';
import 'dart:convert' show utf8;
import 'dart:io' show Platform;

class DynamicLinkService {
  static void initDynamicLinks(BuildContext context) async {
    print('START: initDynamicLinks()');
    FirebaseDynamicLinks.instance;
    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    // A listener for link callbacks when the app is in background calling

    FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData data) async {
      // var appModel = Provider.of<AppModel>(context, listen: false);
      // appModel.changeIsLoading(true);
      // print('data.asMap() ${data.asMap()}');
      await _handleDynamicLink(context, data.link.toString());
      // appModel.changeIsLoading(false);
    });

    // the getInitialLink() gets the link that opened the app (or null if it was not opened via a dynamic link)
    final deepLink = data?.link;

    if (deepLink != null) {
      printYellow('[firebase-dynamic-link] getInitialLink: $deepLink');
      await _handleDynamicLink(context, deepLink.toString());
    }
  }

  // FULL RESTART The app needed while edit this.
  static Future<void> _handleDynamicLink(BuildContext context, String link) async {
    printYellow('START: _handleDynamicLink()');
    print('link $link'); // https://riltopia.page.link/talme20@gmail.com%5B#a6459%5D
    var postId = Uri.decodeFull(link.split('.link/').last);
    print('postId $postId');
    try {
      context.uniProvider.isLoadingUpdate(true);
      var post = await FeedService.getPostById(postId);
      print('post textContent ${post?.textContent}');
      context.uniProvider.isLoadingUpdate(false);
      context.router.push(CommentsChatRoute(post: post!, isFullScreen: true));
    } catch (err) {
      printYellow('[firebase-dynamic-link] Error: ${err.toString()}');
    }
  }

  static DynamicLinkParameters postParams({
    required String postId,
    required SocialMetaTagParameters socialShareMeta,
  }) {
    var gPlayLink = 'https://play.google.com/store/apps/details?id=com.biton.messaging';
    var iosLink = 'https://apps.apple.com/us/app/riltopia-social-chat-app/id1668583703';
    return DynamicLinkParameters(
        uriPrefix: 'https://riltopia.page.link',
        link: Uri.parse('https://riltopia.page.link/$postId'),
        androidParameters: AndroidParameters(
            packageName: 'com.biton.messaging',
            minimumVersion: 309, // When Share button added
            fallbackUrl: Uri.parse(gPlayLink)),
        iosParameters: IOSParameters(
            bundleId: 'com.biton.messaging',
            minimumVersion: '3.0.9',
            fallbackUrl: Uri.parse(iosLink)),
        socialMetaTagParameters: socialShareMeta);
  }

  /// share product link that contains Dynamic link
  static void sharePostLink({
    required PostModel post,
  }) async {
    var images = [
      // 'https://i.ibb.co/17gtzMP/A-Purple-People-Like-You.png',
      // 'https://i.ibb.co/7rbVQTT/C-Blue-Whats-Around.png',
      // 'https://i.ibb.co/3BBqJCN/B-Orange-Great-Converstions.png',
      // 'https://i.ibb.co/PZkFYs2/D-Yellow-Response-Now.png',
      // 'https://i.ibb.co/vPtjSMp/Filter-Preview-Full-4.png'

      // Same, But with RilTopia logo
      'https://i.ibb.co/b3yL41g/A-Purple-People-Like-You-Ril.png',
      'https://i.ibb.co/JrgsT2D/B-Orange-Great-Converstions-Ril.png',
      'https://i.ibb.co/TRFsh8s/D-Yellow-Response-Now-Ril.png',
      'https://i.ibb.co/4Yf64Ff/C-Blue-Whats-Around-Ril.png',
    ];

    var productParams = postParams(
      postId: post.id,
      socialShareMeta: SocialMetaTagParameters(
        title: "Join ${post.creatorUser?.name}'s Conversation",
        // description: 'RilTopia - Social Chat App',
        description: post.textContent,
        imageUrl: Uri.parse((images..shuffle()).first),
      ),
    );
    // var firebaseDynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(productParams);
    var firebaseDynamicLink = await FirebaseDynamicLinks.instance.buildLink(productParams);

    // print('firebaseDynamicLink.shortUrl.toString() ${firebaseDynamicLink.shortUrl.toString()}');
    // await Share.share(firebaseDynamicLink.toString());
    // return;

    http.Response response;
    try {
      var keyA = UniqueKey().toString().replaceAll('[', '').replaceAll(']', '').replaceAll('#', '');
      var slash = 'RiTopia-$keyA';
      print('slash $slash');
      response = await http.post(Uri.https("api.rebrandly.com", "/v1/links"),
          headers: {
            "apikey": "b4d30300ce9e4a609d7776e4a1df5f8f",
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            // 'domain': {'id': 'c0f887ba9eb4461cab7d12b714f8644b'},
            'slashtag': slash,
            // 'destination': '${firebaseDynamicLink.shortUrl}',
            'destination': '$firebaseDynamicLink',
          }));
      printYellow(response.body);
      if (response.statusCode == 200) {
        await Share.share(
          'https://${(jsonDecode(response.body) as Map<String, dynamic>)['shortUrl']}',
        );
      } else {
        await Share.share(firebaseDynamicLink.toString());
      }
    } catch (e) {
      printRed('$e');
      await Share.share(firebaseDynamicLink.toString());
    }
  }
}
