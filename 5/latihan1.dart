class Expense {
  String description;
  double amount;
  String category;
  DateTime date;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
  });

  // Mendapatkan nomor minggu ISO (1..53)
  int getWeekNumber() {
    // Hari ke-berapa dalam tahun (1..365/366)
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final dayOfYear = date.difference(firstDayOfYear).inDays + 1;

    // Rumus ISO week number
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  // Mendapatkan kuartal (1 – 4)
  int getQuarter() {
    return ((date.month - 1) / 3).floor() + 1;
  }

  // Mengecek apakah akhir pekan
  bool isWeekend() {
    return date.weekday == DateTime.saturday ||
           date.weekday == DateTime.sunday;
  }
}

void main() {
  var expense = Expense(
    description: 'Brunch akhir pekan',
    amount: 45.00,
    category: 'Makanan',
    date: DateTime(2025, 10, 11), // Sabtu
  );

  print('Kuartal: ${expense.getQuarter()}');      // => 4
  print('Akhir pekan? ${expense.isWeekend()}');  // => true
  print('Minggu ke: ${expense.getWeekNumber()}'); // contoh output: 41 (tergantung aturan ISO)
}