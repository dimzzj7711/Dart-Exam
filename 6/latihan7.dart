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
    return amount >= 100;
  }

  
  bool isThisMonth() {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  String getSummary() {
    return '$description - Rp${amount.toStringAsFixed(2)} ($category)';
  }


  String getFullDisplay() {
    return '$description | Rp${amount.toStringAsFixed(2)} | '
        '$category | ${isPaid ? "Sudah dibayar" : "Belum dibayar"} | '
        '${date.day}/${date.month}/${date.year}';
  }
}