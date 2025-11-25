
class Expense {
  final String description;
  final double amount;
  final String category;
  final DateTime date;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  void printDetails() {
    print(' PENGELUARAN');
    print('Deskripsi : $description');
    print('Kategori  : $category');
    print('Jumlah    : Rp${amount.toStringAsFixed(2)}');
    print('Tanggal   : ${date.toIso8601String()}');
  }
}


class RecurringExpense extends Expense {
  final String frequency; 

  RecurringExpense({
    required String description,
    required double amount,
    required String category,
    required this.frequency,
  }) : super(
          description: description,
          amount: amount,
          category: category,
        );

 
  double yearlyTotal() {
    switch (frequency.toLowerCase()) {
      case 'harian':
        return amount * 365;
      case 'mingguan':
        return amount * 52;
      case 'bulanan':
        return amount * 12;
      default:
        return amount;
    }
  }
}


class SubscriptionExpense extends RecurringExpense {
  final String provider;
  final String plan;
  final DateTime startDate;
  final DateTime? endDate;

  SubscriptionExpense({
    required String description,
    required double amount,
    required this.provider,
    required this.plan,
    required this.startDate,
    this.endDate,
  }) : super(
          description: description,
          amount: amount,
          category: 'Langganan',
          frequency: 'bulanan',
        );

  bool isActive() {
    if (endDate == null) return true; 
    return DateTime.now().isBefore(endDate!);
  }

  int getRemainingMonths() {
    if (endDate == null) return -1; 

    final now = DateTime.now();
    if (now.isAfter(endDate!)) return 0;

    return (endDate!.year - now.year) * 12 +
        (endDate!.month - now.month);
  }

  double getTotalCost() {
    if (endDate == null) {
      
      return yearlyTotal();
    }

    final months = (endDate!.year - startDate.year) * 12 +
        (endDate!.month - startDate.month);

    return amount * (months <= 0 ? 1 : months);
  }

  @override
  void printDetails() {
    print(' LANGGANAN');
    print('$description ($provider - $plan)');
    print('Biaya        : Rp${amount.toStringAsFixed(2)}/bulan');
    print('Mulai        : ${startDate.toString().split(" ")[0]}');

    if (endDate != null) {
      print('Berakhir     : ${endDate.toString().split(" ")[0]}');
      print('Sisa waktu   : ${getRemainingMonths()} bulan');
    } else {
      print('Berakhir     : Tidak ada (berkelanjutan)');
    }

    print('Status       : ${isActive() ? "Aktif " : "Expired "}');
    print('Total biaya  : Rp${getTotalCost().toStringAsFixed(2)}');
  }
}


void main() {
  var netflix = SubscriptionExpense(
    description: 'Netflix Premium',
    amount: 186000,
    provider: 'Netflix',
    plan: 'Premium 4K',
    startDate: DateTime(2024, 1, 1),
    endDate: null,
  );

  var trial = SubscriptionExpense(
    description: 'Adobe Creative Cloud',
    amount: 800000,
    provider: 'Adobe',
    plan: 'All Apps',
    startDate: DateTime(2025, 9, 1),
    endDate: DateTime(2025, 12, 31),
  );

  netflix.printDetails();
  print('');
  trial.printDetails();
}
