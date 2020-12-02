import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:workshop_demo/ui/app/app_wm.dart';
import 'package:workshop_demo/ui/app/di/app_component.dart';
import 'package:workshop_demo/ui/app/di/app_wm_builder.dart';

class App extends MwwmWidget<AppComponent> {
  App({
    Key key,
    WidgetModelBuilder wmBuilder = createAppWm,
  }) : super(
          key: key,
          dependenciesBuilder: (_) => AppComponent(),
          widgetStateBuilder: () => _AppState(),
          widgetModelBuilder: wmBuilder,
        );
}

class _AppState extends WidgetState<AppWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workshop demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: Injector.of<AppComponent>(context).component.navigatorKey,
      home: Scaffold(
        key: Injector.of<AppComponent>(context).component.scaffoldKey,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
