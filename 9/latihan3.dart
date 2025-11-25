class User {
  final String username;
  String password;
  String email;


  final List<Expense> expenses = [];

  User({
    required this.username,
    required this.password,
    required this.email,
  });

  void addExpense(Expense expense) {
    expenses.add(expense);
    print('💰 Pengeluaran ditambahkan untuk $username: ${expense.amount}');
  }

  void showExpenses() {
    if (expenses.isEmpty) {
      print('📭 Belum ada pengeluaran untuk $username');
      return;
    }

    print('\n📌 Daftar Pengeluaran $username');
    for (var e in expenses) {
      print('- ${e.category} : Rp ${e.amount}');
    }
  }
}

class UserManager {
  final Map<String, User> _users = {}; 
  User? _loggedInUser;


  bool register(String username, String password, String email) {
    if (_users.containsKey(username)) {
      print('❌ Username sudah dipakai');
      return false;
    }

    _users[username] = User(
      username: username,
      password: password,
      email: email,
    );

    print('✅ User "$username" berhasil dibuat');
    return true;
  }

  bool login(String username, String password) {
    if (!_users.containsKey(username)) {
      print('❌ User tidak ditemukan');
      return false;
    }

    var user = _users[username]!;
    if (user.password != password) {
      print('❌ Password salah');
      return false;
    }

    _loggedInUser = user;
    print('🔐 Login berhasil sebagai $username');
    return true;
  }


  void logout() {
    if (_loggedInUser == null) {
      print('⚠️ Tidak ada user yang login');
    } else {
      print('🚪 User ${_loggedInUser!.username} logout');
      _loggedInUser = null;
    }
  }


  User? get currentUser => _loggedInUser;
}

class Expense {
  final String category;
  final double amount;

  Expense({
    required this.category,
    required this.amount,
  });
}
