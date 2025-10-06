import 'package:baby_kit2/models/cart_providers.dart';
import 'package:baby_kit2/models/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  final List<Product> products;

  const CheckoutPage({super.key, required this.products});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller untuk input data
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedShipping; // Pilihan kurir
  String? _selectedPayment; // Pilihan metode pembayaran

  // Data ongkos kirim
  final Map<String, double> shippingCosts = {
    "JNE": 5000,
    "J&T": 5000,
    "SiCepat": 7000,
    "POS Indonesia": 10000,
  };

  // Daftar metode pembayaran
  final List<String> paymentMethods = ["Transfer Bank", "OVO", "GoPay", "COD"];

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    // Hitung total harga produk
    double totalPrice = widget.products.fold(0, (sum, item) {
      int qty = cartProvider.quantity[item] ?? 1;
      double price =
          double.tryParse(
            item.price.replaceAll("Rp", "").replaceAll(".", ""),
          ) ??
          0;
      return sum + (price * qty);
    });

    // Total harga + ongkir
    double totalWithShipping =
        totalPrice + (shippingCosts[_selectedShipping] ?? 0);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.pink[400],
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // Jika tidak ada produk
      body: widget.products.isEmpty
          ? const Center(child: Text("Tidak ada produk yang dipilih"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Daftar produk yang dibeli
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.pink[50],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.shopping_bag_outlined,
                                color: Colors.pink[400],
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              "Daftar Produk",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Tampilkan semua produk
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.products.length,
                          itemBuilder: (context, index) {
                            final product = widget.products[index];
                            int qty = cartProvider.quantity[product] ?? 1;
                            double price =
                                double.tryParse(
                                  product.price
                                      .replaceAll("Rp", "")
                                      .replaceAll(".", ""),
                                ) ??
                                0;
                            double subtotal = price * qty;

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey[200]!,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      product.image,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Rp ${subtotal.toStringAsFixed(0)}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.pink[400],
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.pink[50],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "x$qty",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink[400],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Form alamat pengiriman
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.pink[50],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.pink[400],
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "Alamat Pengiriman",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Input nama penerima
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: "Nama Penerima",
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Colors.pink[300],
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Nama penerima wajib diisi";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Input nomor HP
                          TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              labelText: "Nomor HP",
                              prefixIcon: Icon(
                                Icons.phone_outlined,
                                color: Colors.pink[300],
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Nomor HP wajib diisi";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Input alamat lengkap
                          TextFormField(
                            controller: _addressController,
                            decoration: InputDecoration(
                              labelText: "Alamat Lengkap",
                              prefixIcon: Icon(
                                Icons.home_outlined,
                                color: Colors.pink[300],
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                            maxLines: 3,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Alamat wajib diisi";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Pilihan metode pengiriman
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Pilih Kurir",
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedShipping,
                      items: shippingCosts.keys
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedShipping = val;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Pilihan metode pembayaran
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Pilih Metode Pembayaran",
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedPayment,
                      items: paymentMethods
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedPayment = val;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),

      // Bagian bawah untuk total dan tombol bayar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Total pembayaran
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total Pembayaran"),
                  Text(
                    "Rp ${totalWithShipping.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[400],
                    ),
                  ),
                ],
              ),

              // Tombol bayar
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      _selectedShipping != null &&
                      _selectedPayment != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Pesanan berhasil dibuat."),
                        backgroundColor: Colors.green[400],
                      ),
                    );
                    cartProvider.clearCart();
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.shopping_cart_checkout, size: 20),
                    SizedBox(width: 8),
                    Text("Bayar Sekarang"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
