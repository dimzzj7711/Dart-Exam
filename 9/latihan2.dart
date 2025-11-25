class Budget {
  final String category;
  double limit;
  double _spent = 0;

  Budget({required this.category, required this.limit});


  void addExpense(double amount) {
    _spent += amount;
  }


  double get spent => _spent;


  double get remaining => limit - _spent;


  bool get isNearLimit => _spent >= limit * 0.8 && _spent < limit;


  bool get isExceeded => _spent > limit;


  void printReport() {
    print('--- Budget Kategori: $category ---');
    print('Limit: Rp $limit');
    print('Terpakai: Rp $_spent');
    print('Sisa: Rp ${remaining < 0 ? 0 : remaining}');

    if (isExceeded) {
      print('⚠️ PERINGATAN: Budget melebihi limit!');
    } else if (isNearLimit) {
      print('⚠️ Hati-hati: Sudah mencapai 80% limit!');
    } else {
      print('✅ Masih aman.');
    }
    print('');
  }
}

class BudgetManager {
  final Map<String, Budget> _budgets = {};


  void setBudget(String category, double limit) {
    _budgets[category] = Budget(category: category, limit: limit);
    print('Budget kategori "$category" diset: Rp $limit');
  }


  void addExpense(String category, double amount) {
    if (!_budgets.containsKey(category)) {
      print('❌ Tidak ada budget untuk kategori "$category".');
      return;
    }

    _budgets[category]!.addExpense(amount);

    if (_budgets[category]!.isExceeded) {
      print('⚠️ Pengeluaran di kategori "$category" melebihi limit!');
    } else if (_budgets[category]!.isNearLimit) {
      print('⚠️ Pengeluaran kategori "$category" mendekati limit!');
    }
  }


  void printAllReports() {
    print('\n===== LAPORAN BUDGET BULANAN =====');
    for (var budget in _budgets.values) {
      budget.printReport();
    }
  }
}
