import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultScreen extends StatefulWidget {
  final String name;
  final String lastName;
  final String email;

  ResultScreen({
    this.name,
    this.lastName,
    this.email,
  });

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildItem('Имя', widget.name),
            _buildItem('Фамилия', widget.lastName),
            _buildItem('Email', widget.email),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: RichText(
        text: TextSpan(
            text: title,
            style: TextStyle(fontWeight: FontWeight.bold),
            children: [
              TextSpan(text: ':'),
              TextSpan(text: value),
            ]),
      ),
    );
  }
}
