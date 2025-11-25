// ==========================================
// ABSTRACT CLASS : PAYMENT METHOD
// ==========================================
abstract class PaymentMethod {
  String get name;
  String get icon;

  /// Default validator (bisa dioverride)
  bool validate() => true;

  /// Wajib diimplementasikan
  void processPayment(double amount);

  /// Cetak struk standar
  void showReceipt(double amount) {
    print('--- Struk Pembayaran ---');
    print('Metode : $name');
    print('Jumlah : \$${amount.toStringAsFixed(2)}');
    print('Status : Berhasil ✅');
    print('-------------------------\n');
  }
}

abstract class Refundable {
  bool canRefund();
  void processRefund(double amount);
}


class CreditCard extends PaymentMethod implements Refundable {
  final String cardNumber;
  final String cardHolder;

  final List<double> transactions = [];

  CreditCard({
    required this.cardNumber,
    required this.cardHolder,
  });

  @override
  String get name => 'Kartu Kredit';

  @override
  String get icon => '💳';

 
  @override
  void processPayment(double amount) {
    if (amount <= 0) {
      print('❌ Nominal tidak valid untuk pembayaran: \$${amount.toStringAsFixed(2)}');
      return;
    }

    transactions.add(amount);
    print('$icon Mendebet \$${amount.toStringAsFixed(2)} untuk $cardHolder');
    showReceipt(amount);
  }

  double getAvailableRefundAmount() {
    final double totalCharges = transactions.where((t) => t > 0).fold(0.0, (a, b) => a + b);
    final double totalRefunds = transactions.where((t) => t < 0).fold(0.0, (a, b) => a + b); 
    return totalCharges + totalRefunds; 
  }

  @override
  bool canRefund() => getAvailableRefundAmount() > 0.0;

  
  @override
  void processRefund(double amount) {
    if (amount <= 0) {
      print('❌ Nominal refund harus lebih besar dari 0');
      return;
    }

    final available = getAvailableRefundAmount();
    if (available <= 0) {
      print('❌ Tidak ada transaksi yang bisa direfund');
      return;
    }

    if (amount > available) {
      print('❌ Permintaan refund \$${amount.toStringAsFixed(2)} melebihi saldo refund yang tersedia (\$${available.toStringAsFixed(2)})');
      return;
    }

   
    transactions.add(-amount);
    print('🔄 Memproses refund \$${amount.toStringAsFixed(2)} untuk $cardHolder');
    print('   Refund akan kembali dalam 3–5 hari kerja');
    showReceipt(-amount); 
  }
}


class Cash extends PaymentMethod {
  @override
  String get name => 'Tunai';

  @override
  String get icon => '💵';

  @override
  void processPayment(double amount) {
    if (amount <= 0) {
      print('❌ Nominal tidak valid untuk pembayaran tunai: \$${amount.toStringAsFixed(2)}');
      return;
    }

    print('$icon Pembayaran tunai sebesar \$${amount.toStringAsFixed(2)}');
    showReceipt(amount);
  }
}


void main() {
  var card = CreditCard(
    cardNumber: '4532123456789012',
    cardHolder: 'John Doe',
  );

  var cash = Cash();

 
  card.processPayment(100.0);

 
  card.processRefund(50.0);

 
  card.processRefund(60.0);

  
  cash.processPayment(50.0);

 
  // ignore: unnecessary_type_check
  print('Card refundable? ${card is Refundable}');
  print('Cash refundable? ${cash is Refundable}');

  
  print('Available refund (card): \$${card.getAvailableRefundAmount().toStringAsFixed(2)}');
}

