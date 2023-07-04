import 'package:flutter/cupertino.dart';

import 'base_lifecycle.dart';
import 'base_widget_view.dart';
import 'base_page_transition.dart';

class BaseState<T extends BaseWidgetView> extends BasePageTransition<T>
    with WidgetsBindingObserver
    implements SimpleLifeCycle {
  late AnimationController _animationController;
  late Animation<Offset> animation;

  var milliSecondsDurationAnimationPageTransition = 600;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: milliSecondsDurationAnimationPageTransition),
    )..forward();
    animation = Tween<Offset>(
      begin: const Offset(-1, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInToLinear,
    ));

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
        {}
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
