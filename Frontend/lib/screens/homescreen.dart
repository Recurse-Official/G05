// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'category_detail_screen.dart'; // Import the new file
import '../utils/bottomnavigation.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
   final Map<String, Map<String, Map<String, String>>> foodCategories = {
    'Breakfast': {
      'Idli': {'image': 'assets/images/Idli.jpeg', 'price': '25', 'name': 'Idli'},
      'Sambar Idly': {'image': 'assets/images/Idli Sambhar.jpeg', 'price': '30', 'name': 'Sambar Idly'},
      'Sambar Dosa': {'image': 'assets/images/Sambar Dosa.jpeg', 'price': '50', 'name': 'Sambar Dosa'},
      'Wada Puri': {'image': 'assets/images/Vada Puri.jpeg', 'price': '25', 'name': 'Wada Puri'},
      'Tea': {'image': 'assets/images/Tea.jpeg', 'price': '8', 'name': 'Tea'},
      'Coffee': {'image': 'assets/images/Coffee.jpeg', 'price': '10', 'name': 'Coffee'},
    },
    'Snacks': {
      'Samosa': {'image': 'assets/images/Samosa.jpeg', 'price': '10', 'name': 'Samosa'},
      'Puff': {'image': 'assets/images/Puff.jpeg', 'price': '15', 'name': 'Puff'},
      'Spring Roll': {'image': 'assets/images/Spring Roll.jpeg', 'price': '45', 'name': 'Spring Roll'},
      'Manchuria': {'image': 'assets/images/Manchuria.jpeg', 'price': '50', 'name': 'Manchuria'},
      'Gobi 65': {'image': 'assets/images/Gobi 65.jpeg', 'price': '70', 'name': 'Gobi 65'},
    },
    'Meals': {
      'Chapathi Meals': {'image': 'assets/images/Chapati Meals.jpeg', 'price': '30', 'name': 'Chapathi Meals'},
      'Fried Rice': {'image': 'assets/images/Fried Rice.jpeg', 'price': '35', 'name': 'Fried Rice'},
      'Veg Biriyani': {'image': 'assets/images/Veg Biriyani.jpeg', 'price': '50', 'name': 'Veg Biriyani'},
      'Paneer Fried Rice': {'image': 'assets/images/Paneer Fride Rice.jpeg', 'price': '60', 'name': 'Paneer Fried Rice'},
      'Zeera Rice': {'image': 'assets/images/Zeera Rice.jpeg', 'price': '40', 'name': 'Zeera Rice'},
    },
    'Other Dishes': {
      'Noodles': {'image': 'assets/images/Noodles.jpeg', 'price': '55', 'name': 'Noodles'},
      'Chilli Paneer': {'image': 'assets/images/Chilli Paneer.jpeg', 'price': '50', 'name': 'Chilli Paneer'},
      'Paneer Noodles Mix': {'image': 'assets/images/Paneer Noodles Mix.jpeg', 'price': '60', 'name': 'Paneer Noodles Mix'},
      'Shezwan Noodles Mix': {'image': 'assets/images/Shezwan Noodles Mix.jpeg', 'price': '50', 'name': 'Shezwan Noodles Mix'},
      'Pasha Mix': {'image': 'assets/images/Pasta.jpeg', 'price': '70', 'name': 'Pasha Mix'},
    },
    'Sweets': {
      'G. Pulla Reddy Sweets': {'image': 'assets/images/Reddy Sweets.jpg', 'price': '70', 'name': 'G. Pulla Reddy Sweets'},
      'Kaju Kathili': {'image': 'assets/images/Kaju Kathili.jpg', 'price': '70', 'name': 'Kaju Kathili'},
      'Assorted Sweets': {'image': 'assets/images/Assorted Sweets.jpg', 'price': '70', 'name': 'Assorted Sweets'},
    },
  };

  void _showProductDialog(BuildContext context, Map<String, String> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int quantity = 1;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(item['name']!),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    item['image']!,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('Add to Cart'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Breakfast':
        return Icons.breakfast_dining;
      case 'Snacks':
        return Icons.fastfood;
      case 'Meals':
        return Icons.lunch_dining;
      case 'Other Dishes':
        return Icons.dinner_dining;
      case 'Sweets':  
        return Icons.cake;
      default:
        return Icons.category;
    }
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.orange,
          centerTitle: true,
          title: const Text(
            'Welcome!',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order Food',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: foodCategories.keys.length,
                  itemBuilder: (context, index) {
                    String category = foodCategories.keys.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryDetailScreen(
                              category: category,
                              items: foodCategories[category]!.values.toList(),
                              onItemTap: _showProductDialog,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getCategoryIcon(category),
                              size: 50,
                              color: Colors.orange,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              category,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}
