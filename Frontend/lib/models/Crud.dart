import 'dart:convert';
import 'dart:ffi';
import 'package:DigiCanteen/models/Product.dart';
import 'package:http/http.dart' as http;

class CartService {
  final String baseUrl = "http://localhost:3000/api"; // Adjust URL as needed

  // Add product to cart
  Future<void> addToCart(String rollNumber, Product product,Int) async {
    final url = Uri.parse('$baseUrl/cart/$rollNumber');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'productId': product.ProductId,
        'rollName': product.rollNumber,
        'quantity': product.quantity,
      }),
    );
    if (response.statusCode == 200) {
      print('Item added to cart');
    } else {
      throw Exception('Failed to add item to cart');
    }
  }

  // View cart
  Future<List<Product>> viewCart(String rollNumber) async {
    final url = Uri.parse('$baseUrl/cart/$rollNumber');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load cart');
    }
  }

  // Delete product from cart
  Future<void> deleteFromCart(String rollNumber, String productId) async {
    final url = Uri.parse('$baseUrl/cart/$rollNumber/$productId');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print('Item deleted from cart');
    } else {
      throw Exception('Failed to delete item from cart');
    }
  }
}