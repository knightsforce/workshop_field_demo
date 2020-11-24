import 'package:flutter/material.dart';
import 'package:workshop_demo/validators.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final List<Validator> validators;
  final String labelText;

  CustomTextField({
    this.controller,
    this.focusNode,
    this.validators,
    this.labelText,
  });

  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<CustomTextField> {
  TextEditingController _controller;
  FocusNode _focusNode;

  bool _isAutoValidate = false;

  List<Validator> get _validators => widget.validators;

  bool get _isNotExistValidators => widget?.validators?.isEmpty ?? true;

  String get _text => _controller.text;

  AutovalidateMode get _autoValidateMode => _isAutoValidate
      ? AutovalidateMode.always
      : AutovalidateMode.disabled;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onChangeFocus);
    _controller.addListener(_onChangeText);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_onChangeText);
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onChangeFocus);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      validator: _validate,
      autovalidateMode: _autoValidateMode,
      decoration: InputDecoration(
        labelText: widget.labelText,
      ),
    );
  }

  void _onChangeText() {
    if(_isAutoValidate || _text.isEmpty) return;
    _isAutoValidate = true;
    setState(() {});
  }

  void _onChangeFocus() {
    if (_focusNode.hasFocus || _isAutoValidate) {
      return;
    }

    /// Чтобы при первом фокусе не было ошибки
    _isAutoValidate = true;

    setState(() {});
  }

  /// Необходимо использовать функцию чтобы
  /// запускалась валидация от формы
  String _validate(String text) {
    if (_isNotExistValidators) {
      return null;
    }

    for (Validator validator in _validators) {
      if (validator.isValid(_text)) continue;
      return validator.errorText ?? '';
    }

    return null;
  }
}
