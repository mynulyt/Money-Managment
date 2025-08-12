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

  void _addEntry(String title, double amount, DateTime date, bool isEarning) {
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

  void _showFABOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.pop(context);
                  _showForm(isEarning: true);
                },
                child: Text(
                  "Add Earning",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.pop(context);
                  _showForm(isEarning: false);
                },
                child: Text(
                  "Add Earning",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showForm({required bool isEarning}) {
    TextEditingController titleController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    DateTime entryDate = DateTime.now();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              Text(
                isEarning ? 'Add Earning' : 'Add Expense',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  label: Text("Title"),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  label: Text("Title"),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isEarning ? Colors.green : Colors.red,
                  ),

                  onPressed: () {
                    if (titleController.text.isEmpty &&
                        amountController.text.isEmpty) {
                      _addEntry(
                        titleController.text,
                        double.parse(amountController.text),
                        entryDate,
                        isEarning,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    isEarning ? 'Add Earning' : "Add Expense",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFABOptions(context),
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                _buildCardSummary(
                  title: "Earningh",
                  value: 500,
                  color: Colors.green,
                ),
                _buildCardSummary(
                  title: "Earningh",
                  value: 500,
                  color: Colors.green,
                ),
                _buildCardSummary(
                  title: "Earningh",
                  value: 500,
                  color: Colors.green,
                ),
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

  Widget _buildCardSummary({
    required String title,
    required double value,
    required Color color,
  }) {
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
