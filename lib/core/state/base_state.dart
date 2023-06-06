import 'package:flutter/cupertino.dart';

import 'base_lifecycle.dart';
import 'base_widget_view.dart';

class BaseState<T extends BaseWidgetView> extends State<T>
    with WidgetsBindingObserver
    implements SimpleLifeCycle {
  @override
  void initState() {
    super.initState();
    onViewCreated();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        {
          onResume();
        }
        break;
      case AppLifecycleState.paused:
        {
          onPause();
        }
        break;
      case AppLifecycleState.inactive:
        {
          onStop();
        }
        break;
      case AppLifecycleState.detached:
        {

        }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void onPause() {
    print("onPause");
  }

  @override
  void onResume() {
    print("onResume");
  }

  @override
  void onStop() {}

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void onRecreate() {
    print("onView Recreated");
    onViewCreated();
  }

  @override
  void onStart() {}

  @override
  void onViewCreated() {}
}

