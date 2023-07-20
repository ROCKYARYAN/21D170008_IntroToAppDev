import 'package:flutter/material.dart';

void main() {
  runApp(BudgetTrackerApp());
}

class BudgetTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tracker',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double income = 1000.0;
  double totalExpenses = 185.0;

  @override
  Widget build(BuildContext context) {
    double totalBalance = income - totalExpenses;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Budget Tracker'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildHomeCard('Total Expenses', '\$${totalExpenses.toStringAsFixed(2)}', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExpensesScreen(),
                ),
              );
            }),
            _buildHomeCard('Total Income', '\$${income.toStringAsFixed(2)}', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IncomeScreen(),
                ),
              );
            }),
            _buildHomeCard('Total Balance', '\$${totalBalance.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeCard(String title, String value, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpensesScreen extends StatelessWidget {
  final List<Expense> expenses = [
    Expense(category: 'Groceries', amount: 50.0, description: 'Bought groceries'),
    Expense(category: 'Utilities', amount: 40.0, description: 'Electricity and Water bill'),
    Expense(category: 'Car Maintenance', amount: 80.0, description: 'Tyre Replacement'),
    Expense(category: 'Entertainment', amount: 15.0, description: 'Movie tickets'),
  ];

  @override
  Widget build(BuildContext context) {
    double totalExpenses =
    expenses.fold(0, (sum, expense) => sum + expense.amount);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Total Expenses: \$${totalExpenses.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, color: Colors.yellowAccent),

            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${expenses[index].description}'),
                  subtitle: Text('\$${expenses[index].amount.toStringAsFixed(2)}'),
                  textColor: Colors.yellowAccent,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddExpenseDialog(context);
              },
              child: Text('Add Expense'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String description = '';
        double value = 0.0;

        return AlertDialog(
          title: Text('Add Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (val) => description = val,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Value'),
                onChanged: (val) => value = double.tryParse(val) ?? 0.0,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Here you can add logic to handle the adding of the expense
                // For now, we will just print the values
                print('Description: $description, Value: $value');
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class IncomeScreen extends StatelessWidget {
  final List<Income> incomes = [
    Income(source: 'Salary', amount: 800.0),
    Income(source: 'Passive Income', amount: 200.0),
  ];

  @override
  Widget build(BuildContext context) {
    double totalIncome = incomes.fold(0, (sum, income) => sum + income.amount);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Income'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Total Income: \$${totalIncome.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, color: Colors.cyan[400]),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: incomes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${incomes[index].source}'),
                  subtitle: Text('\$${incomes[index].amount.toStringAsFixed(2)}'),
                  textColor: Colors.cyan[400],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddIncomeDialog(context);
              },
              child: Text('Add Income'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddIncomeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String source = '';
        double value = 0.0;

        return AlertDialog(
          title: Text('Add Income'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Source'),
                onChanged: (val) => source = val,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Value'),
                onChanged: (val) => value = double.tryParse(val) ?? 0.0,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Here you can add logic to handle the adding of the income
                // For now, we will just print the values
                print('Source: $source, Value: $value');
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class Expense {
  final String category;
  final double amount;
  final String description;

  Expense({required this.category, required this.amount, required this.description});
}

class Income {
  final String source;
  final double amount;

  Income({required this.source, required this.amount});
}
