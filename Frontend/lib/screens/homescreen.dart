import 'package:DigiCanteen/screens/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      'Idli': {
        'image': 'assets/images/Idli.jpeg',
        'price': '25',
        'name': 'Idli',
        'productId': 'P001'
      },
      'Sambar Idly': {
        'image': 'assets/images/Idli Sambhar.jpeg',
        'price': '30',
        'name': 'Sambar Idly',
        'productId': 'P002'
      },
      'Sambar Dosa': {
        'image': 'assets/images/Sambar Dosa.jpeg',
        'price': '50',
        'name': 'Sambar Dosa',
        'productId': 'P003'
      },
      'Wada Puri': {
        'image': 'assets/images/Vada Puri.jpeg',
        'price': '25',
        'name': 'Wada Puri',
        'productId': 'P004'
      },
      'Tea': {
        'image': 'assets/images/Tea.jpeg',
        'price': '8',
        'name': 'Tea',
        'productId': 'P005'
      },
      'Coffee': {
        'image': 'assets/images/Coffee.jpeg',
        'price': '10',
        'name': 'Coffee',
        'productId': 'P006'
      },
    },
    'Snacks': {
      'Samosa': {
        'image': 'assets/images/Samosa.jpeg',
        'price': '10',
        'name': 'Samosa'
      },
      'Puff': {
        'image': 'assets/images/Puff.jpeg',
        'price': '15',
        'name': 'Puff'
      },
      'Spring Roll': {
        'image': 'assets/images/Spring Roll.jpeg',
        'price': '45',
        'name': 'Spring Roll'
      },
      'Manchuria': {
        'image': 'assets/images/Manchuria.jpeg',
        'price': '50',
        'name': 'Manchuria'
      },
      'Gobi 65': {
        'image': 'assets/images/Gobi 65.jpeg',
        'price': '70',
        'name': 'Gobi 65'
      },
    },
    'Meals': {
      'Chapathi Meals': {
        'image': 'assets/images/Chapati Meals.jpeg',
        'price': '30',
        'name': 'Chapathi Meals'
      },
      'Fried Rice': {
        'image': 'assets/images/Fried Rice.jpeg',
        'price': '35',
        'name': 'Fried Rice'
      },
      'Veg Biriyani': {
        'image': 'assets/images/Veg Biriyani.jpeg',
        'price': '50',
        'name': 'Veg Biriyani'
      },
      'Paneer Fried Rice': {
        'image': 'assets/images/Paneer Fride Rice.jpeg',
        'price': '60',
        'name': 'Paneer Fried Rice'
      },
      'Zeera Rice': {
        'image': 'assets/images/Zeera Rice.jpeg',
        'price': '40',
        'name': 'Zeera Rice'
      },
    },
    'Chinese Food': {
      'Noodles': {
        'image': 'assets/images/Noodles.jpeg',
        'price': '55',
        'name': 'Noodles'
      },
      'Chilli Paneer': {
        'image': 'assets/images/Chilli Paneer.jpeg',
        'price': '50',
        'name': 'Chilli Paneer'
      },
      'Paneer Noodles Mix': {
        'image': 'assets/images/Paneer Noodles Mix.jpeg',
        'price': '60',
        'name': 'Paneer Noodles Mix'
      },
      'Shezwan Noodles Mix': {
        'image': 'assets/images/Shezwan Noodles Mix.jpeg',
        'price': '50',
        'name': 'Shezwan Noodles Mix'
      },
      'Pasta Mix': {
        'image': 'assets/images/Pasta.jpeg',
        'price': '70',
        'name': 'Pasta Mix'
      },
    },
  };

  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  ThemeData get _currentTheme {
    return _isDarkMode
        ? ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.grey[900],
            appBarTheme: const AppBarTheme(color: Colors.black),
            textTheme:
                const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
          )
        : ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(color: Colors.orange),
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
      case 'Chinese Food':
        return Icons.dinner_dining;
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
                  final cart = Provider.of<CartProvider>(context, listen: false);
                  for (var i = 0; i < quantity; i++) {
                    cart.addItem(item['productId']!);
                  }
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _currentTheme,
      home: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: _isDarkMode ? Colors.black : Colors.orange,
            centerTitle: true,
            title: const Text(
              'HomePage!',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
                onPressed: _toggleTheme,
              ),
            ],
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
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                items:
                                    foodCategories[category]!.values.toList(),
                                onItemTap: _showProductDialog,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: _isDarkMode ? Colors.grey[800] : Colors.white,
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
                                color:
                                    _isDarkMode ? Colors.orange : Colors.black,
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
          bottomNavigationBar: BottomNavigation(currentIndex: 0, onTap: (index) {  },),
        ),
      ),
    );
  }
}

