class Product {
  // nama produk
  final String name;

  // harga produk (dalam format string, contoh: "Rp 25.000")
  final String price;

  // link atau path gambar produk
  final String image;

  // deskripsi produk
  final String description;

  // kategori produk (contoh: makanan, obat, perlengkapan, dll)
  final String category;

  // daftar informasi gizi (khusus untuk produk makanan)
  final List<String> nutrition;

  // konstruktor produk
  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
    this.nutrition = const [], // default kosong jika tidak diisi
  });

  // getter untuk menentukan tingkat keamanan produk
  String get safetyLevel {
    switch (category.toLowerCase()) {
      case "makanan":
        return "Food Grade / Aman Dikonsumsi"; // untuk makanan

      case "demam/flu":
      case "obat":
      case "vitamin":
        return "Dikonsultasikan dengan dokter / Gunakan sesuai dosis"; // untuk obat atau vitamin

      case "perlengkapan":
        return "Aman untuk bayi / Bebas bahan berbahaya"; // untuk perlengkapan

      default:
        return "Aman digunakan"; // kategori lain
    }
  }
}
