import 'package:flutter/material.dart';

class MoneyManagment extends StatefulWidget {
  const MoneyManagment({super.key});

  @override
  State<MoneyManagment> createState() => _MoneyManagmentState();
}

class _MoneyManagmentState extends State<MoneyManagment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          "Money Management",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
