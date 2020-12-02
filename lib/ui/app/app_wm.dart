import 'package:flutter/cupertino.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:workshop_demo/interactor/profile_interactor.dart';
import 'package:workshop_demo/ui/screen/auth/auth_screen_route.dart';
import 'package:workshop_demo/ui/screen/main/main_screen_route.dart';

class AppWidgetModel extends WidgetModel {
  final GlobalKey<NavigatorState> _navigatorKey;
  final ProfileInteractor _profileInteractor;

  AppWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigatorKey,
    this._profileInteractor,
  ) : super(dependencies);

  @override
  void onLoad() async {
    super.onLoad();

    if (await _profileInteractor.isDataSaved) {
      _navigatorKey.currentState.pushReplacement(MainScreenRoute());
      return;
    }
    _navigatorKey.currentState.pushReplacement(
      AuthScreenRoute(title: 'Create Profile'),
    );
  }
}
