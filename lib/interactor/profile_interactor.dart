import 'dart:convert';

import 'package:relation/relation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_demo/domain/profile_data.dart';

class ProfileInteractor {
  static const _dataKey = 'data';

  EntityStreamedState<ProfileData> profileDataState = EntityStreamedState()
    ..loading();

  Future<bool> get isDataSaved => _sp.then((sp) => sp.containsKey(_dataKey));

  ProfileData get data => profileDataState.value?.data;

  Future<SharedPreferences> get _sp => SharedPreferences.getInstance();

  set data(ProfileData newData) {
    profileDataState.content(newData);
    _saveData(newData);
  }

  ProfileInteractor() {
    _init();
  }

  void clear() async {
    profileDataState.content(ProfileData());
    final sp = await _sp;
    sp.remove(_dataKey);
  }

  void _saveData(ProfileData newData) async {
    final sp = await _sp;
    sp.setString(_dataKey, newData.toJSON());
  }

  void _init() async {
    final sp = await _sp;
    if (!sp.containsKey(_dataKey)) {
      profileDataState.content(ProfileData());
      return;
    }
    profileDataState.content(ProfileData.fromJSON(sp.getString(_dataKey)));
  }
}
