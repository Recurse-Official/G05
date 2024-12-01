import 'package:DigiCanteen/models/Crud.dart';
import 'package:DigiCanteen/models/Product.dart';
import 'package:flutter/material.dart';
import 'cart.dart';
import 'cart_indicator.dart';
import 'dart:developer' as developer;

class CategoryDetailScreen extends StatefulWidget {
  final String category;
  final List<Map<String, String>> items;
  final Function(BuildContext, Map<String, String>) onItemTap;

  const CategoryDetailScreen({
    Key? key,
    required this.category,
    required this.items,
    required this.onItemTap,
  }) : super(key: key);

  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  late Map<int, int> itemQuantities;
  final CartService cartService = CartService();
  final String rollNumber = "22BD1A050J"; // Replace with actual roll number

  @override
  void initState() {
    super.initState();
    itemQuantities = {for (int i = 0; i < widget.items.length; i++) i: 0};
  }

  void incrementQuantity(int index) async {
    setState(() {
      itemQuantities[index] = itemQuantities[index]! + 1;
    });

    final item = widget.items[index];
    final product = Product(
      ProductId: item['productId']!, // Assuming 'id' exists in item map
      Name: item['name']!,
      Price: double.parse(item['price']!),
      Image: item['image']!,
      quantity: itemQuantities[index]!,
      rollNumber: rollNumber,
    );

    try {
      await cartService.addToCart(rollNumber, product, itemQuantities[index]!);
      developer.log('Item added to cart');
    } catch (e) {
      developer.log('Failed to add item to cart: $e');
    }
  }

  void decrementQuantity(int index) async {
    if (itemQuantities[index]! > 0) {
      setState(() {
        itemQuantities[index] = itemQuantities[index]! - 1;
      });

      final item = widget.items[index];
      final productId = item['id']!; // Assuming  'id' exists in item map

      try {
        await cartService.deleteFromCart(rollNumber, productId);
        developer.log('Item removed from cart');
      } catch (e) {
        developer.log('Failed to remove item from cart: $e');
      }
    }
  }

  int get totalItems => itemQuantities.values.fold(0, (previous, current) => previous + current);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.category),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                Map<String, String> item = widget.items[index];
                int quantity = itemQuantities[index]!;

                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          item['image']!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '₹${item['price']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item['description'] ?? '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        quantity == 0
                            ? IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  incrementQuantity(index);
                                },
                              )
                            : Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline),
                                    onPressed: () {
                                      decrementQuantity(index);
                                    },
                                  ),
                                  Text(
                                    '$quantity',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline),
                                    onPressed: () {
                                      incrementQuantity(index);
                                    },
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          CartIndicator(
            itemCount: totalItems,
            onViewCart: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    itemQuantities: itemQuantities,
                    items: widget.items,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
