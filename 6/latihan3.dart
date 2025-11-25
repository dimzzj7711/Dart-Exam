class Expense {
  String description;
  double amount;
  String category;
  bool isPaid;
  DateTime date;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    this.isPaid = false,
    DateTime? date,
  }) : date = date ?? DateTime.now();

 
  bool isMajorExpense() {
    return amount > 100;
  }

 
  bool isThisMonth() {
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  
  String getSummary() {
    return '[${category}] $description - Rp ${amount.toStringAsFixed(2)} '
           '(${isPaid ? "PAID" : "UNPAID"})';
  }
}

class ExpenseManager {
  List<Expense> _expenses = [];

  void addExpense(Expense expense) {
    _expenses.add(expense);
  }

  List<Expense> getAllExpenses() => List.from(_expenses);

  List<Expense> getByCategory(String category) {
    List<Expense> filtered = [];
    for (var expense in _expenses) {
      if (expense.category == category) {
        filtered.add(expense);
      }
    }
    return filtered;
  }

 
  List<Expense> getByAmountRange(double min, double max) {
    List<Expense> filtered = [];
    for (var expense in _expenses) {
      if (expense.amount >= min && expense.amount <= max) {
        filtered.add(expense);
      }
    }
    return filtered;
  }

 
  List<Expense> getMajorExpenses() {
    List<Expense> filtered = [];
    for (var expense in _expenses) {
      if (expense.isMajorExpense()) {
        filtered.add(expense);
      }
    }
    return filtered;
  }

 
  List<Expense> getThisMonth() {
    List<Expense> filtered = [];
    for (var expense in _expenses) {
      if (expense.isThisMonth()) {
        filtered.add(expense);
      }
    }
    return filtered;
  }

  
  List<Expense> getPaidExpenses() {
    List<Expense> filtered = [];
    for (var expense in _expenses) {
      if (expense.isPaid) {
        filtered.add(expense);
      }
    }
    return filtered;
  }

  List<Expense> getUnpaidExpenses() {
    List<Expense> filtered = [];
    for (var expense in _expenses) {
      if (!expense.isPaid) {
        filtered.add(expense);
      }
    }
    return filtered;
  }
}

void main() {
  var manager = ExpenseManager();

  manager.addExpense(Expense(description: 'Coffee', amount: 4.50, category: 'Food'));
  manager.addExpense(Expense(description: 'Rent', amount: 1200.0, category: 'Bills', isPaid: true));
  manager.addExpense(Expense(description: 'Laptop', amount: 899.99, category: 'Electronics'));
  manager.addExpense(Expense(description: 'Lunch', amount: 15.75, category: 'Food'));

  print('EXPENSES MAKANAN:');
  for (var expense in manager.getByCategory('Food')) {
    print(expense.getSummary());
  }

  print('\nMAJOR EXPENSES (>Rp100):');
  for (var expense in manager.getMajorExpenses()) {
    print(expense.getSummary());
  }

  print('\nEXPENSES BELUM DIBAYAR:');
  for (var expense in manager.getUnpaidExpenses()) {
    print(expense.getSummary());
  }
}