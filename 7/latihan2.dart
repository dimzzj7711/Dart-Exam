class Expense {
  final String description;
  final double amount;
  final String category;
  final DateTime date;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
  });

  void printDetails() {
    print(' PENGELUARAN UMUM');
    print('   Deskripsi : $description');
    print('   Kategori  : $category');
    print('   Jumlah    : Rp${amount.toStringAsFixed(2)}');
    print('   Tanggal   : ${date.toIso8601String()}');
  }
}