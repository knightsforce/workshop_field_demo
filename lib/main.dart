import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_demo/result_screen.dart';
import 'package:workshop_demo/text_field.dart';
import 'package:workshop_demo/validators.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workshop Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _isLoading = true;

  Map<FieldId, TextEditingController> _controllers = {
    FieldId.name: TextEditingController(),
    FieldId.lastName: TextEditingController(),
    FieldId.email: TextEditingController(),
  };

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  void dispose() {
    _controllers.forEach((key, value) => value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              widget.title,
              style: const TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
          body: _buildBody(),
        ),
        if (_isLoading) _buildLoader()
      ],
    );
  }

  Widget _buildLoader() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.transparent,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ///Форму добавить после валидации
          WillPopScope(
            onWillPop: _onWillPop,
            child: _buildForm(),
          ),
          OutlineButton(
            child: Text('Регистрация'),
            onPressed: _onPressed,
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            labelText: 'Имя',
            controller: _controllers[FieldId.name],
            validators: [
              NoEmptyValidator('Поле не должно быть пустым'),
            ],
          ),
          const SizedBox(height: 10),
          CustomTextField(
            labelText: 'Фамилия',
            controller: _controllers[FieldId.lastName],
            validators: [
              NoEmptyValidator('Поле не должно быть пустым'),
            ],
          ),
          const SizedBox(height: 10),
          CustomTextField(
            labelText: 'Email',
            controller: _controllers[FieldId.email],
            validators: [
              NoEmptyValidator('Поле не должно быть пустым'),
              EmailValidator('Невалидный email'),
            ],
          ),
        ],
      ),
    );
  }

  void _initData() async {
    var sp = await SharedPreferences.getInstance();

    String text;

    for (FieldId id in FieldId.values) {
      text = sp.getString(id.value);
      if (text == null) continue;
      _controllers[id]?.text = text;
    }

    _isLoading = false;
    setState(() {});
  }

  Future<void> _saveData() async {
    var sp = await SharedPreferences.getInstance();

    for (FieldId id in FieldId.values) {
      if (!_controllers.containsKey(id)) continue;
      sp.setString(id.value, _controllers[id].text);
    }
  }

  void _onPressed() async {
    final bool isValid = _formKey.currentState.validate();

    if (!isValid) return;

    var sp = await SharedPreferences.getInstance();
    sp.clear();

    _navToResult();
  }

  Future<bool> _onWillPop() async {
    _isLoading = true;
    setState(() {});
    await _saveData();
    _isLoading = false;
    setState(() {});
    return true;
  }

  void _navToResult() {
    Navigator.of(context).pushReplacement(
      Platform.isAndroid
          ? MaterialPageRoute(builder: _buildRoute)
          : CupertinoPageRoute(builder: _buildRoute),
    );
  }

  Widget _buildRoute(context) {
    return ResultScreen(
      name: _controllers[FieldId.name].text,
      lastName: _controllers[FieldId.lastName].text,
      email: _controllers[FieldId.email].text,
    );
  }
}

enum FieldId {
  name,
  lastName,
  email,
}

extension on FieldId {
  String get value {
    switch (this) {
      case FieldId.name:
        return 'name';
      case FieldId.lastName:
        return 'lastName';
      case FieldId.email:
        return 'email';
    }
    return '';
  }
}
