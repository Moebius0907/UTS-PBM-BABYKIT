import 'package:baby_kit2/models/cart_providers.dart';
import 'package:baby_kit2/models/products.dart';
import 'package:baby_kit2/pages/obat.dart';
import 'package:baby_kit2/pages/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// 🔹 Daftar produk
final List<Product> products = [
  Product(
    image: "assets/images/sgm.png",
    name: "SGM Ananda 1 (0-6 Bulan)",
    price: "Rp 120.000",
    description:
        "Susu formula untuk bayi 0-6 bulan, membantu pertumbuhan optimal dan daya tahan tubuh si kecil.",
    category: "makanan",
    nutrition: [
      "Protein: 1.2g",
      "Lemak: 5g",
      "Karbohidrat: 10g",
      "Vitamin: A, D, C",
    ],
  ),
  Product(
    image: "assets/images/promina puffs blue.png",
    name: "Promina Puffs Blueberry Makanan Bayi [15 g]",
    price: "Rp 7.000",
    description:
        "Camilan sehat untuk bayi, terbuat dari bahan alami, cocok sebagai snack finger food pertama anak.",
    category: "makanan",
    nutrition: ["Karbohidrat: 12g", "Protein: 0.5g", "Vitamin: C"],
  ),
  Product(
    image: "assets/images/zwitsal hair lotion.png",
    name: "Zwitsal Baby Hair Lotion Aloe Vera Kemiri Botol [100 ml]",
    price: "Rp 25.000",
    description:
        "Lotion rambut bayi dengan Aloe Vera dan Kemiri, menjaga kelembutan rambut dan kulit kepala bayi.",
    category: "perlengkapan",
    nutrition: [],
  ),
  Product(
    image: "assets/images/bye bye fever.png",
    name: "Bye Bye Fever Bayi [10 lembar]",
    price: "Rp 90.000",
    description:
        "Plester penurun demam dan pereda panas untuk bayi, lembut di kulit dan aman digunakan.",
    category: "obat",
    nutrition: [],
  ),
  Product(
    image: "assets/images/baby happy M.png",
    name: "Pampers Baby Happy [M]",
    price: "Rp 55.000",
    description:
        "Popok bayi ukuran M, nyaman dan menyerap dengan baik, menjaga kulit bayi tetap kering.",
    category: "perlengkapan",
    nutrition: [],
  ),
  Product(
    image: "assets/images/dot pigeon.png",
    name: "Botol Susu Bayi Pigeon [120 ml]",
    price: "Rp 30.000",
    description:
        "Botol susu bayi kapasitas 120 ml, aman dan mudah digunakan, mendukung pemberian ASI tambahan.",
    category: "perlengkapan",
    nutrition: [],
  ),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // 🔹 Widget kartu produk
  Widget _buildProductCard(BuildContext context, Product product) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final isFavorite = cartProvider.isFavorite(product);

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.asset(
                      product.image,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        cartProvider.toggleFavorite(product);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              cartProvider.isFavorite(product)
                                  ? "${product.name} ditambahkan ke favorit"
                                  : "${product.name} dihapus dari favorit",
                            ),
                            backgroundColor: Colors.pink[300],
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey[400],
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Nama produk
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  product.price,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
              ),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol lihat detail
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailPage(product: product),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Lihat",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Tombol keranjang
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.pink.shade200,
                      size: 24,
                    ),
                    onPressed: () {
                      cartProvider.addToCart(product);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${product.name} ditambahkan ke keranjang",
                          ),
                          backgroundColor: Colors.pink.shade200,
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // 🔹 Widget kategori biar ga ngulang
  Widget _buildCategory(IconData icon, String label, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 90,
        height: 120,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                shape: BoxShape.circle,
              ),
              child: FaIcon(icon, size: 30, color: Colors.pink[300]),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ AppBar dengan search dan icon
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.only(left: 25, right: 8),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari produk...",
                hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.solidMessage,
              color: Colors.pink[300],
            ),
            onPressed: () {
              // aksi chat
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.pink[300]),
            onPressed: () {
              // aksi notifikasi
            },
          ),
        ],
      ),

      // ✅ Isi halaman
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/banner.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 180,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Kategori
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Kategori",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildCategory(
                        FontAwesomeIcons.pills,
                        "Obat & Suplemen Bayi",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ObatSuplemenBayiPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 25),
                      _buildCategory(
                        FontAwesomeIcons.baby,
                        "Susu & Skincare Bayi",
                      ),
                      const SizedBox(width: 35),
                      _buildCategory(
                        FontAwesomeIcons.utensils,
                        "Makanan & Perlengkapan lainnya",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Produk populer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Produk Populer",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.7,
                        ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _buildProductCard(context, product);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
