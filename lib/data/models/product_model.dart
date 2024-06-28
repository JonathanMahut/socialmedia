import 'package:cloud_firestore/cloud_firestore.dart';

// Use UpperCamelCase for enum names
enum ProductCategory {
  ink,
  equipment,
  aftercare,
  // ... other supplier categories
}

class Product {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final String supplierId;
  final double price;
  final int quantity;
  final ProductCategory category;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Consider using named parameters for clarity, especially for classes with many fields
  Product({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.supplierId,
    required this.price,
    required this.quantity,
    required this.category,
    this.isAvailable = true,
    required this.createdAt,
    required this.updatedAt,
  })  : assert(name.isNotEmpty, 'Product name cannot be empty'),
        assert(description.isNotEmpty, 'Product description cannot be empty'),
        assert(price >= 0, 'Product price cannot be negative'),
        assert(quantity >= 0, 'Product quantity cannot be negative');

  // Factory constructor for creating a Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      supplierId: json['supplierId'] as String,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      category: _productCategoryFromString(json['category'] as String?),
      isAvailable: json['isAvailable'] as bool? ?? true,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // Method to convert a Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'supplierId': supplierId,
      'price': price,
      'quantity': quantity,
      'category': category.name, // Store category as enum name
      'isAvailable': isAvailable,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Method to create a copy of a Product with optional modifications
  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? supplierId,
    double? price,
    int? quantity,
    ProductCategory? category,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      supplierId: supplierId ?? this.supplierId,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper method to convert string to ProductCategory
  static ProductCategory _productCategoryFromString(String? categoryString) {
    if (categoryString != null) {
      try {
        return ProductCategory.values.byName(categoryString);
      } catch (e) {
        // Handle invalid enum value (e.g., log error, return default)
        print('Invalid ProductCategory: $categoryString');
        return ProductCategory.ink; // Default value
      }
    }
    return ProductCategory.ink; // Default value if categoryString is null
  }
}
