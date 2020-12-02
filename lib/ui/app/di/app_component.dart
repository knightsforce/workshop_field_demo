//import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:workshop_demo/interactor/profile_interactor.dart';

class AppComponent implements Component {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final navigatorKey = GlobalKey<NavigatorState>();

  ProfileInteractor profileInteractor;

  AppComponent() {
    profileInteractor = ProfileInteractor();
  }
}
