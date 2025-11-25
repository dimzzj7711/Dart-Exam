class Expense {
  String description;
  double amount;
  String category;
  DateTime date;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  // Format tanggal agar bisa diprint
  String getFormattedDate() {
    return '${date.day}-${date.month}-${date.year}';
  }
}