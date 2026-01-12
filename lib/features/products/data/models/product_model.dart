import 'package:hive/hive.dart';
import '../../domain/entities/product_entity.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final num price;

  @HiveField(4)
  final num discountPercentage;

  @HiveField(5)
  final num rating;

  @HiveField(6)
  final num stock;

  @HiveField(7)
  final String brand;

  @HiveField(8)
  final String category;

  @HiveField(9)
  final String thumbnail;

  @HiveField(10)
  final List<String> images;

  @HiveField(11)
  final String availabilityStatus;

  @HiveField(12)
  final String warrantyInformation;

  @HiveField(13)
  final String returnPolicy;

  ProductModel({
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

  ProductEntity toEntity() => ProductEntity(
    id: id,
    title: title,
    description: description,
    price: price,
    discountPercentage: discountPercentage,
    rating: rating,
    stock: stock,
    brand: brand,
    category: category,
    thumbnail: thumbnail,
    images: images,
    availabilityStatus: availabilityStatus,
    warrantyInformation: warrantyInformation,
    returnPolicy: returnPolicy,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?) ?? 0,
      discountPercentage: (json['discountPercentage'] as num?) ?? 0,
      rating: (json['rating'] as num?) ?? 0,
      stock: json['stock'] ?? 0,
      brand: json['brand'] ?? '',
      category: json['category'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      images: (json['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
      availabilityStatus: json['availabilityStatus'] ?? '',
      warrantyInformation: json['warrantyInformation'] ?? '',
      returnPolicy: json['returnPolicy'] ?? '',
    );
  }

  static final fakeProduct = ProductModel(
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
