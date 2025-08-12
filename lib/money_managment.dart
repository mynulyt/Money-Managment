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
                  label: Text("Amount"),
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
                    if (titleController.text.isNotEmpty &&
                        amountController.text.isNotEmpty) {
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
          labelStyle: const TextStyle(
            // ✅ Selected tab style
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            // ✅ Unselected tab style
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          labelColor: Colors.white, // ✅ Selected tab text color
          unselectedLabelColor: Colors.white70, // ✅ Unselected tab text color
          indicatorColor: Colors.yellow, // ✅ Indicator line color
          tabs: const [
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
                  title: "Earning",
                  value: totalEarning,
                  color: Colors.green,
                ),
                _buildCardSummary(
                  title: "Expense",
                  value: totalExpense,
                  color: Colors.red,
                ),
                _buildCardSummary(
                  title: "T/Balance",
                  value: balance,
                  color: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buldCard(_earning, Colors.green, true),
                  _buldCard(_expense, Colors.red, false),
                ],
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
                "${value} ৳",
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

  Widget _buldCard(
    List<Map<String, dynamic>> items,
    Color color,
    bool isEarning,
  ) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isEarning ? Colors.green : Colors.red,
              child: Icon(
                isEarning ? Icons.arrow_upward : Icons.arrow_downward,
                color: Colors.white,
              ),
            ),
            title: Text(items[index]['title']),
            subtitle: Text(items[index]['date'].toString()),
            trailing: Text(
              "৳${items[index]['amount']}",
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
