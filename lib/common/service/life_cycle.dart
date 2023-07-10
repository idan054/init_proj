import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/service/online_service.dart';
import 'package:flutter/material.dart';

import 'Database/firebase_db.dart';

var appState = AppLifecycleState.resumed;

class LifeCycleManager extends StatefulWidget {
  // final VoidCallback onAppResumed;
  // final VoidCallback onAppPaused;
  final Widget child;

  const LifeCycleManager({
    Key? key,
    required this.child,
    // required this.onAppPaused,
    // required this.onAppResumed,
  }) : super(key: key);

  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('START: didChangeAppLifecycleState state = $state');
    appState = state;

    if (appState == AppLifecycleState.resumed) {
      print('START: onAppResumed()');
      OnlineService.setUserOnlineStatus(context, isOnline: true);
    }
    if (
        //  appState == AppLifecycleState.inactive ||
        //  appState == AppLifecycleState.detached ||
        appState == AppLifecycleState.paused) {
      print('START: onAppPaused()');
      OnlineService.setUserOnlineStatus(context, isOnline: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}
