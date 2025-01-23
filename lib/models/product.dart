class Product {
  final String userName;
  final String profileImage;
  final String productName;
  final String productImage;
  final String productTypeIcon;
  final String productTime;
  final String productCategory;
  final String userId;
  final String description;

  Product({
    required this.userName,
    required this.profileImage,
    required this.productImage,
    required this.productName,
    required this.productTypeIcon,
    required this.productTime,
    required this.productCategory,
    required this.userId,
    required this.description,
  });

  // Supabase from JSON Factory
  factory Product.fromSupabase(Map<String, dynamic> json) {
    return Product(
      userName: json['userName'],
      profileImage: json['profileImage'],
      productImage: json['productImage'],
      productName: json['productName'],
      productTypeIcon: json['productTypeIcon'] ??
          'timer_outlined', // defaults to timer if not found
      productTime: json['productTime'],
      productCategory: json['productCategory'],
      userId: json['userId'],
      description: json['description'],
    );
  }

  // Supabase to JSON method
  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "profileImage": profileImage,
      "productImage": productImage,
      "productName": productName,
      "productTypeIcon": productTypeIcon,
      "productTime": productTime,
      "productCategory": productCategory,
      "userId": userId,
      "description": description,
    };
  }
}
