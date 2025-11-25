class Expense {
  final String description;
  final double amount;
  final String category;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
  });

  
  Expense.quick({
    required String description,
    required double amount,
    required String category,
  }) : this(
          description: description,
          amount: amount,
          category: category,
        );

  String getSummary() {
    return '[$category] $description - \$${amount.toStringAsFixed(2)}';
  }
}

void main() {

  List<Expense> expenses = [];

  
  expenses.add(Expense.quick(description: 'Coffee', amount: 4.50, category: 'Food'));
  expenses.add(Expense.quick(description: 'Lunch', amount: 12.75, category: 'Food'));
  expenses.add(Expense.quick(description: 'Gas', amount: 45.00, category: 'Transport'));

  print('Expense pertama: ${expenses[0].description}');
  print('Total jumlah: ${expenses.length}');

 
  print('\nSemua expenses:');
  for (var expense in expenses) {
    print(expense.getSummary());
  }

 
  expenses.removeAt(1);  
  print('\nSetelah hapus lunch: ${expenses.length} expenses');
}