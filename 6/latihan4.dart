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

  
  String getSummary() {
    return '[${category}] $description - Rp ${amount.toStringAsFixed(2)} '
           '(${isPaid ? "PAID" : "UNPAID"})';
  }
}





class ExpenseManager {
  List<Expense> _expenses = [];

  void addExpense(Expense expense) => _expenses.add(expense);

 
  double getTotalSpending() {
    double total = 0;
    for (var expense in _expenses) {
      total += expense.amount;
    }
    return total;
  }

 
  double getTotalByCategory(String category) {
    double total = 0;
    for (var expense in _expenses) {
      if (expense.category == category) {
        total += expense.amount;
      }
    }
    return total;
  }

 
  double getAverageExpense() {
    if (_expenses.isEmpty) return 0;
    return getTotalSpending() / _expenses.length;
  }

 
  Expense? getLargestExpense() {
    if (_expenses.isEmpty) return null;

    Expense largest = _expenses[0];
    for (var expense in _expenses) {
      if (expense.amount > largest.amount) {
        largest = expense;
      }
    }
    return largest;
  }

    Expense? getSmallestExpense() {
    if (_expenses.isEmpty) return null;

    Expense smallest = _expenses[0];
    for (var expense in _expenses) {
      if (expense.amount < smallest.amount) {
        smallest = expense;
      }
    }
    return smallest;
  }

    int countByCategory(String category) {
    int count = 0;
    for (var expense in _expenses) {
      if (expense.category == category) {
        count++;
      }
    }
    return count;
  }

  
  List<String> getAllCategories() {
    List<String> categories = [];
    for (var expense in _expenses) {
      if (!categories.contains(expense.category)) {
        categories.add(expense.category);
      }
    }
    return categories;
  }

 
  double getTotalUnpaid() {
    double total = 0;
    for (var expense in _expenses) {
      if (!expense.isPaid) {
        total += expense.amount;
      }
    }
    return total;
  }

   Map<String, double> getCategoryBreakdown() {
    Map<String, double> breakdown = {};
    for (var expense in _expenses) {
      breakdown[expense.category] =
          (breakdown[expense.category] ?? 0) + expense.amount;
    }
    return breakdown;
  }
}