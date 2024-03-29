import 'package:flutter/material.dart';

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

class _LifeCycleManagerState extends State<LifeCycleManager>
    with WidgetsBindingObserver {
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
    }
    if (
        //  appState == AppLifecycleState.inactive ||
        //  appState == AppLifecycleState.detached ||
        appState == AppLifecycleState.paused) {
      print('START: onAppPaused()');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}
