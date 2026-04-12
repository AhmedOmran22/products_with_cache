class ProductEntity {
  final int id;
  final String title;
  final String description;
  final num price;
  final num discountPercentage;
  final num rating;
  final num stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;
  final String availabilityStatus;
  final String warrantyInformation;
  final String returnPolicy;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
    required this.availabilityStatus,
    required this.warrantyInformation,
    required this.returnPolicy,
  });

  static const fake = ProductEntity(
    id: 193,
    title: "Watch Gold for Women",
    description:
        "The Gold Women's Watch is a stunning accessory that combines luxury and style. Featuring a gold-plated case and a chic design, it adds a touch of glamour to any outfit.",
    price: 799.99,
    discountPercentage: 18.34,
    rating: 4.24,
    stock: 0,
    brand: "Fashion Gold",
    category: "womens-watches",
    thumbnail:
        "https://cdn.dummyjson.com/product-images/womens-watches/watch-gold-for-women/thumbnail.webp",
    images: [
      "https://cdn.dummyjson.com/product-images/womens-watches/watch-gold-for-women/1.webp",
      "https://cdn.dummyjson.com/product-images/womens-watches/watch-gold-for-women/2.webp",
      "https://cdn.dummyjson.com/product-images/womens-watches/watch-gold-for-women/3.webp",
    ],
    availabilityStatus: "Out of Stock",
    warrantyInformation: "2 year warranty",
    returnPolicy: "60 days return policy",
  );
}
