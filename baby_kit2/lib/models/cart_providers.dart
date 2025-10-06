import 'package:flutter/material.dart';
import 'package:baby_kit2/models/products.dart';
import 'package:intl/intl.dart';

class CartProvider with ChangeNotifier {
  // daftar produk di keranjang
  final List<Product> _cartItems = [];

  // jumlah tiap produk
  final Map<Product, int> _quantity = {};

  // riwayat pesanan
  final List<Map<String, dynamic>> _orderHistory = [];

  List<Product> get cartItems => _cartItems;
  Map<Product, int> get quantity => _quantity;
  List<Map<String, dynamic>> get orderHistory => _orderHistory;

  // tambah produk ke keranjang
  void addToCart(Product product) {
    if (!_cartItems.contains(product)) {
      _cartItems.add(product);
      _quantity[product] = 1;
    } else {
      _quantity[product] = (_quantity[product] ?? 0) + 1;
    }
    notifyListeners();
  }

  // hapus produk dari keranjang
  void removeFromCart(Product product) {
    _cartItems.remove(product);
    _quantity.remove(product);
    notifyListeners();
  }

  // tambah jumlah produk
  void increaseQuantity(Product product) {
    _quantity[product] = (_quantity[product] ?? 0) + 1;
    notifyListeners();
  }

  // kurangi jumlah produk
  void decreaseQuantity(Product product) {
    if ((_quantity[product] ?? 0) > 1) {
      _quantity[product] = (_quantity[product] ?? 0) - 1;
    } else {
      removeFromCart(product);
    }
    notifyListeners();
  }

  // kosongkan keranjang
  void clearCart() {
    _cartItems.clear();
    _quantity.clear();
    notifyListeners();
  }

  // tambah pesanan ke riwayat
  void addOrderToHistory({
    required List<Product> products,
    required double totalPrice,
    required String shippingMethod,
    required String paymentMethod,
    required String customerName,
    required String customerPhone,
    required String customerAddress,
  }) {
    // buat ID pesanan
    final orderId = 'INV${_orderHistory.length + 1}'.padLeft(6, '0');

    // format tanggal pesanan
    final now = DateTime.now();
    final dateFormatter = DateFormat('dd MMM yyyy', 'id');
    final formattedDate = dateFormatter.format(now);

    // ubah produk ke format data pesanan
    final orderProducts = products.map((product) {
      final qty = _quantity[product] ?? 1;
      final price = double.tryParse(
            product.price.replaceAll("Rp", "").replaceAll(".", "").trim(),
          ) ??
          0;

      return {
        "name": product.name,
        "price": price.toInt(),
        "qty": qty,
        "image": product.image,
      };
    }).toList();

    // buat objek pesanan
    final order = {
      "id": orderId,
      "date": formattedDate,
      "status": "Dikemas", // status awal
      "total": totalPrice.toInt(),
      "products": orderProducts,
      "shipping": shippingMethod,
      "payment": paymentMethod,
      "customer": {
        "name": customerName,
        "phone": customerPhone,
        "address": customerAddress,
      },
    };

    // tambahkan ke riwayat (paling atas)
    _orderHistory.insert(0, order);

    // hapus produk dari keranjang setelah dipesan
    for (var product in products) {
      removeFromCart(product);
    }

    notifyListeners();
  }

  // ubah status pesanan
  void updateOrderStatus(String orderId, String newStatus) {
    final orderIndex = _orderHistory.indexWhere(
      (order) => order['id'] == orderId,
    );
    if (orderIndex != -1) {
      _orderHistory[orderIndex]['status'] = newStatus;
      notifyListeners();
    }
  }

  // daftar produk favorit
  final List<Product> _favoriteItems = [];

  List<Product> get favoriteItems => _favoriteItems;

  // tambah ke favorit
  void addToFavorites(Product product) {
    if (!_favoriteItems.contains(product)) {
      _favoriteItems.add(product);
      notifyListeners();
    }
  }

  // hapus dari favorit
  void removeFromFavorites(Product product) {
    _favoriteItems.remove(product);
    notifyListeners();
  }

  // cek apakah produk favorit
  bool isFavorite(Product product) {
    return _favoriteItems.contains(product);
  }

  // ubah status favorit (on/off)
  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      removeFromFavorites(product);
    } else {
      addToFavorites(product);
    }
  }
}
