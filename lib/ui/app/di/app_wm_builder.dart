import 'package:flutter/cupertino.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:workshop_demo/base/error_handler.dart';
import 'package:workshop_demo/ui/app/app_wm.dart';
import 'package:workshop_demo/ui/app/di/app_component.dart';

AppWidgetModel createAppWm(BuildContext context) {
  final component = Injector.of<AppComponent>(context).component;
  final dependencies = WidgetModelDependencies(
    errorHandler: BaseErrorHandler(),
  );

  ///NavigatorKey
  return AppWidgetModel(
    dependencies,
    component.navigatorKey,
    component.profileInteractor,
  );
}
