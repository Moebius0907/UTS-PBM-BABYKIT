import 'package:baby_kit2/pages/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baby_kit2/models/cart_providers.dart';
import 'package:baby_kit2/models/products.dart';

class ObatSuplemenBayiPage extends StatefulWidget {
  const ObatSuplemenBayiPage({super.key});

  @override
  State<ObatSuplemenBayiPage> createState() => _ObatSuplemenBayiPageState();
}

class _ObatSuplemenBayiPageState extends State<ObatSuplemenBayiPage> {
  final List<String> categories = ["Semua", "Demam/Flu", "Vitamin", "Lainnya"];
  String selectedCategory = "Semua";

  final List<Product> products = [
    Product(
      name: "Paracetamol Syrup Tempra [15ml]",
      price: "Rp50.000",
      image: "assets/images/tempra.png",
      description:
          "Syrup penurun demam dan obat flu untuk bayi, dengan rasa yang aman dan nyaman diminum.",
      category: "Demam/Flu",
    ),
    Product(
      name: "Vidoran Smart Vitamin Strawberry [25pcs/botol]",
      price: "Rp30.000",
      image: "assets/images/vidoran.png",
      description:
          "Vitamin untuk mendukung tumbuh kembang anak dengan rasa stroberi yang disukai bayi.",
      category: "Vitamin",
    ),
    Product(
      name: "Hufagripp Flu Dan Batuk [60 ml]",
      price: "Rp29.500",
      image: "assets/images/hufagrip.png",
      description:
          "Obat flu dan batuk untuk bayi dengan formula lembut, membantu meringankan gejala pilek dan batuk.",
      category: "Demam/Flu",
    ),
    Product(
      name: "PIGEON Baby Diaper Rash Cream [60gr]",
      price: "Rp35.000",
      image: "assets/images/pigeon_salep.png",
      description:
          "Krim ruam popok untuk bayi, membantu melindungi kulit dan mencegah iritasi akibat popok.",
      category: "Salep",
    ),
    Product(
      name: "LACTO-B 1 GR 10 SACHET",
      price: "Rp20.000",
      image: "assets/images/lactob.png",
      description:
          "Suplemen probiotik untuk mendukung pencernaan sehat pada bayi dan anak-anak.",
      category: "Lainnya",
    ),
    Product(
      name: "OB Herbal Junior Plus Madu 30ml & 60ml",
      price: "Rp18.000",
      image: "assets/images/ob_herbal.png",
      description:
          "Suplemen herbal dengan madu, membantu meningkatkan daya tahan tubuh, dan energi anak.",
      category: "Lainnya",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = selectedCategory == "Semua"
        ? products
        : products.where((p) => p.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: false,
        title: const Text(
          "Obat & Suplemen Bayi",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;

                return ChoiceChip(
                  showCheckmark: false,
                  label: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: Colors.pink[200],
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onSelected: (_) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const
                   SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final produk = filteredProducts[index];
                    final isFavorite = cartProvider.isFavorite(produk);

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Gambar dengan badge kategori dan favorit
                          Expanded(
                            flex: 5,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.asset(
                                    produk.image,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Badge kategori
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      produk.category,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                // Tombol favorit
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      cartProvider.toggleFavorite(produk);

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            cartProvider.isFavorite(produk)
                                                ? "${produk.name} ditambahkan ke favorit"
                                                : "${produk.name} dihapus dari favorit",
                                          ),
                                          backgroundColor: Colors.pink[300],
                                          duration: const Duration(seconds: 2),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFavorite
                                            ? Colors.red
                                            : Colors.grey[400],
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Info produk
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Nama produk
                                  Expanded(
                                    child: Text(
                                      produk.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),

                                  // Harga
                                  Text(
                                    produk.price,
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),

                                  // Tombol aksi
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 32,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetailPage(
                                                        product: produk,
                                                      ),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.pink.shade100,
                                              padding: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                                      const SizedBox(width: 4),
                                      SizedBox(
                                        width: 36,
                                        height: 32,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            Icons.shopping_cart,
                                            color: Colors.pink.shade200,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            cartProvider.addToCart(produk);

                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "${produk.name} ditambahkan ke keranjang",
                                                ),
                                                backgroundColor:
                                                    Colors.pink.shade200,
                                                duration: const Duration(
                                                  seconds: 2,
                                                ),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}