class Expense {
  String description;
  double amount;
  String category;
  DateTime date;
  bool isPaid;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    DateTime? date,
    this.isPaid = false,
  }) : date = date ?? DateTime.now();


  Expense.quick({
    required this.description,
    required this.amount,
    required this.category,
  })  : date = DateTime.now(),
        isPaid = false;


  String getSummary() {
    return '$description - Rp$amount - $category (${date.day}/${date.month}/${date.year})';
  }
}