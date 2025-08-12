import 'package:flutter/material.dart';

class MoneyManagment extends StatefulWidget {
  const MoneyManagment({super.key});

  @override
  State<MoneyManagment> createState() => _MoneyManagmentState();
}

class _MoneyManagmentState extends State<MoneyManagment> {
  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          "Money Management",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Earning", icon: Icon(Icons.arrow_upward)),
            Tab(text: "Expense", icon: Icon(Icons.arrow_downward)),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Card(
                color: Colors.green,
                child: Column(children: [Text("Earing"), Text("500 TK")]),
              ),
              Card(
                color: Colors.red,
                child: Column(children: [Text("Earing"), Text("500 TK")]),
              ),
              Card(
                color: Colors.blue,
                child: Column(children: [Text("Earing"), Text("500 TK")]),
              ),
            ],
          ),
          SizedBox(height: 10),
          TabBarView(controller: _tabController, children: []),
        ],
      ),
    );
  }
}
