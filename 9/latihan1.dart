class CategoryManager {
  final List<String> _categories = ['Makanan', 'Transportasi', 'Tagihan'];

 
  void addCategory(String category) {
    if (!_categories.contains(category)) {
      _categories.add(category);
      print('Kategori "$category" berhasil ditambahkan.');
    } else {
      print('Kategori "$category" sudah ada.');
    }
  }

 
  void removeCategory(String category) {
    if (_categories.contains(category)) {
      _categories.remove(category);
      print('Kategori "$category" berhasil dihapus.');
    } else {
      print('Kategori "$category" tidak ditemukan.');
    }
  }

 
  List<String> get allCategories => List.unmodifiable(_categories);
}

void main() {
  var manager = CategoryManager();

  print(manager.allCategories); 
  manager.addCategory("Hiburan");
  manager.addCategory("Makanan"); 

  manager.removeCategory("Transportasi");
  manager.removeCategory("Tidak Ada"); 

  print(manager.allCategories); 
}
