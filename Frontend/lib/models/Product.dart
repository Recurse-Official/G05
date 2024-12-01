class Product {
  String ProductId;
  String Name;
  double Price;
  String Image;
  int quantity;
  String rollNumber;

  Product({
    required this.ProductId,
    required this.Name,
    required this.Price,
    required this.Image,
    required this.rollNumber,
    this.quantity = 1,
  });

  // From JSON (when fetching data from API)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      ProductId: json['ProductId'],
      Name: json['Name'],
      Price: json['Price'].toDouble(),
      Image: json['Image'],
      rollNumber: json['rollNumber'],
    );
  }

  // To JSON (for sending to the backend)
  Map<String, dynamic> toJson() {
    return {
      'ProductId': ProductId,
      'Name': Name,
      'Price': Price,
      'Image': Image,
      'rollNumber': rollNumber,
    };
  }
  
}