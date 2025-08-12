import 'package:flutter/material.dart';

class MoneyManagment extends StatefulWidget {
  const MoneyManagment({super.key});

  @override
  State<MoneyManagment> createState() => _MoneyManagmentState();
}

class _MoneyManagmentState extends State<MoneyManagment>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _expense = [];
  List<Map<String, dynamic>> _earning = [];

  double get totalExpense =>
      _expense.fold(0, (sum, item) => sum + item['amount']);
  double get totalEarning =>
      _earning.fold(0, (sum, item) => sum + item['amount']);
  double get balance => totalEarning - totalExpense;

  void addEntry(String title, double amount, DateTime date, bool isEarning) {
    setState(() {
      if (isEarning) {
        _earning.add({"title": title, "amount": amount, "date": date});
      } else {
        _expense.add({"title": title, "amount": amount, "date": date});
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                _buildCardSummary("Earning", 500, Colors.green),
                _buildCardSummary("Expense", 200, Colors.red),
                _buildCardSummary("T\balance", 300, Colors.blue),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [buldCard(), buldCard()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardSummary(String title, double value, Color color) {
    return Expanded(
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(title, style: TextStyle(fontSize: 16, color: Colors.white)),
              Text(
                "${value}tk",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buldCard() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black45,
              child: Icon(Icons.arrow_upward),
            ),
            title: Text("Title"),
            subtitle: Text("Subtile"),
            trailing: Text(
              "tk",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              ),
            ),
          ),
        );
      },
    );
  }
}
