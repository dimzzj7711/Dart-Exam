class Expense {
  final String description;
  final double amount;
  final String category;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
  });

 
  Expense.quick({
    required String description,
    required double amount,
    required String category,
  }) : this(
          description: description,
          amount: amount,
          category: category,
        );

  String getSummary() {
    return '[$category] $description - Rp ${amount.toStringAsFixed(2)}';
  }
}

class ExpenseManager {
  
  List<Expense> _expenses = [];

  
  void addExpense(Expense expense) {
    _expenses.add(expense);
    print('✅ Ditambahkan: ${expense.description}');
  }

 
  List<Expense> getAllExpenses() {
    return List.from(_expenses);
  }

 
  int getCount() {
    return _expenses.length;
  }

 
  double getTotalSpending() {
    double total = 0;
    for (var expense in _expenses) {
      total += expense.amount;
    }
    return total;
  }

 
  void printSummary() {
    print('\n💰 RINGKASAN PENGELUARAN');
    print('Total expenses: ${getCount()}');
    print('Total yang dikeluarkan: Rp${getTotalSpending().toStringAsFixed(2)}');
  }
}

void main() {
  var manager = ExpenseManager();

  manager.addExpense(Expense.quick(description: 'Coffee', amount: 4.50, category: 'Food'));
  manager.addExpense(Expense.quick(description: 'Uber', amount: 12.00, category: 'Transport'));
  manager.addExpense(Expense.quick(description: 'Lunch', amount: 15.75, category: 'Food'));

  manager.printSummary();

  print('\nSemua expenses:');
  for (var expense in manager.getAllExpenses()) {
    print(expense.getSummary());
  }
}