import 'package:flutter/material.dart';

class ObatSuplemenBayiPage extends StatefulWidget {
  const ObatSuplemenBayiPage({super.key});

  @override
  State<ObatSuplemenBayiPage> createState() => _ObatSuplemenBayiPageState();
}

class _ObatSuplemenBayiPageState extends State<ObatSuplemenBayiPage> {
  // daftar kategori filter
  final List<String> categories = ["Semua", "Demam/Flu", "Vitamin", "Lainnya"];

  String selectedCategory = "Semua";

  // contoh data produk
  final List<Map<String, dynamic>> products = [
    {
      "nama": "Paracetamol Syrup Tempra [15ml]",
      "harga": "Rp50.000",
      "kategori": "Demam/Flu",
      "gambar": "assets/images/obat/tempra.png",
    },
    {
      "nama": "Vitamin C Drops",
      "harga": "Rp30.000",
      "kategori": "Vitamin",
      "gambar": "assets/images/obat2.jpg",
    },
    {
      "nama": "Obat Flu Anak",
      "harga": "Rp28.000",
      "kategori": "Demam/Flu",
      "gambar": "assets/images/obat3.jpg",
    },
    {
      "nama": "Multivitamin Bayi",
      "harga": "Rp35.000",
      "kategori": "Vitamin",
      "gambar": "assets/images/obat4.jpg",
    },
    {
      "nama": "Obat Herbal",
      "harga": "Rp20.000",
      "kategori": "Lainnya",
      "gambar": "assets/images/obat5.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // filter produk sesuai kategori
    final filteredProducts = selectedCategory == "Semua"
        ? products
        : products.where((p) => p["kategori"] == selectedCategory).toList();

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

      // isi halaman
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Filter kategori
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
                  onSelected: (value) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                );
              },
            ),
          ),

          // 🔹 Daftar produk
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 kolom
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72, // biar proporsional
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final produk = filteredProducts[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔹 Gambar produk
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.asset(
                              produk["gambar"],
                              height: 110,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // 🔹 Nama produk
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              produk["nama"],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          // 🔹 Harga
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              produk["harga"],
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          // 🔹 Tombol lihat + keranjang
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Tombol lihat
                                TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Lihat detail ${produk["nama"]}",
                                        ),
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.pink[200],
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    minimumSize: const Size(0, 0),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: const Text(
                                    "Lihat",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                // Icon keranjang
                                IconButton(
                                  icon: const Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "${produk["nama"]} ditambahkan ke keranjang",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // 🔹 Badge kategori (kiri atas)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
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
                            produk["kategori"],
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      // 🔹 Icon Love (kanan atas)
                      const Positioned(
                        top: 8,
                        right: 8,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
