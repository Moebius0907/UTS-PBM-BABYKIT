import 'package:baby_kit/pages/obat.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🔹 Daftar produk
final List<Map<String, String>> products = [
  {
    "image": "assets/images/sgm.png",
    "name": "SGM Ananda 1 (0-6 Bulan)",
    "price": "Rp 120.000",
  },
  {
    "image": "assets/images/promina puffs blue.png",
    "name": "Promina Puffs Blueberry Makanan Bayi [15 g]",
    "price": "Rp 7.000",
  },
  {
    "image": "assets/images/zwitsal hair lotion.png",
    "name": "Zwitsal Baby Hair Lotion Aloe Vera Kemiri Botol [100 ml]",
    "price": "Rp 25.000",
  },
  {
    "image": "assets/images/bye bye fever.png",
    "name": "Bye Bye Fever Bayi [10 lembar]",
    "price": "Rp 90.000",
  },
  {
    "image": "assets/images/baby happy M.png",
    "name": "Pampers Baby Happy [M]",
    "price": "Rp 55.000",
  },
  {
    "image": "assets/images/dot pigeon.png",
    "name": "Botol Susu Bayi Pigeon [120 ml]",
    "price": "Rp 30.000",
  },
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  // 🔹 Widget kategori biar ga ngulang
  Widget _buildProductCard(
    BuildContext context,
    String image,
    String name,
    String price,
  ) {
    // state untuk love
    ValueNotifier<bool> isFavorite = ValueNotifier(false);

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
                  image,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: ValueListenableBuilder<bool>(
                  valueListenable: isFavorite,
                  builder: (context, value, _) => GestureDetector(
                    onTap: () {
                      isFavorite.value = !isFavorite.value;
                    },
                    child: Icon(
                      Icons.favorite,
                      color: value ? Colors.pink : Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ],
          ),
          //Gambar produk
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              price,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
          ),
          
          //Tombol lihat + keranjang
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      // aksi lihat detail
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Lihat",
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.pink.shade200,
                  size: 24,
                ),
                onPressed: () {
                  // aksi keranjang
                },
              ),
            ],
          ),
        ],
      ),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ), // jarak kiri dan kanan 16 px
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/banner.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity, // tetap melebar penuh dalam padding
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
                    mainAxisAlignment:
                        MainAxisAlignment.start, //jarak diatur sendiri
                    children: [
                          _buildCategory(
                        FontAwesomeIcons.pills,
                        "Obat & Suplemen Bayi",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ObatSuplemenBayiPage(),
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
                      return _buildProductCard(
                        context,
                        product["image"]!,
                        product["name"]!,
                        product["price"]!,
                      );
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
