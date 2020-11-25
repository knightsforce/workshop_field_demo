import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String name;
  final String lastName;
  final String email;

  ResultScreen({
    this.name,
    this.lastName,
    this.email,
  });

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
            _buildItem('Имя', name),
            _buildItem('Фамилия', lastName),
            _buildItem('Email', email),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        '$title = $value',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
