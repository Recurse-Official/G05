import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final Map<int, int> itemQuantities;
  final List<Map<String, String>> items;

  const CartScreen({
    Key? key,
    required this.itemQuantities,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter items with quantity > 0
    final cartItems = itemQuantities.entries
        .where((entry) => entry.value > 0)
        .map((entry) {
          final item = items[entry.key];
          final quantity = entry.value;
          final price = int.parse(item['price']!) * quantity;
          return {
            'name': item['name']!,
            'quantity': quantity,
            'price': item['price']!,
            'totalPrice': price,
            'image': item['image']!,
          };
        })
        .toList();

    // Calculate the total bill
    final totalAmount = cartItems.fold<int>(
      0,
      (sum, item) => sum + (item['totalPrice'] as int),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Your Cart'),
        elevation: 4,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              // item['image']! as String,
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg/1280px-Good_Food_Display_-_NCI_Visuals_Online.jpg',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            item['name'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            '₹${item['price']} x ${item['quantity']} = ₹${item['totalPrice']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          trailing: Text(
                            '₹${item['totalPrice']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '₹$totalAmount',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                      shadowColor: Colors.black.withOpacity(0.3),
                    ),
                    onPressed: () {
                      // Handle checkout logic here
                    },
                    child: const Text(
                      'Proceed to Pay',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
