import 'package:flutter/material.dart';
import 'base_widget_view.dart';

abstract class BasePageTransition<T extends BaseWidgetView> extends State<T>
    with TickerProviderStateMixin {}
