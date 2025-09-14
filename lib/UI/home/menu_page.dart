import 'package:deli_pos/component/menuCard.dart';
import 'package:deli_pos/filterData/local_data.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;

  final List<String> _labels = [
    "Fruits",
    "Drinks",
    "Snacks",
    "Burger",
    "Noodies",
    "Pizza",
  ];
  final List<dynamic> _icons = [
    Icons.food_bank,
    Icons.local_drink,
    Icons.fastfood,
    'assets/pizzaIcon.png',
    'assets/ramenIcon.png',
    'assets/burgerIcon.png',
  ];
  final List<int> _itemCount = [83, 50, 32, 44, 31, 55];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_circle_left_rounded,
                          color: Color(0xFFFF8C00),
                          size: 30,
                        ),
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, '/'),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Menu',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              //Search Bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const SizedBox(
                    height: 35,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search, size: 18),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16,
                        ),
                        border: InputBorder.none, // Removes the black border
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //Category Tab
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_icons.length, (index) {
                  bool isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      padding: EdgeInsets.symmetric(
                        horizontal: isSelected
                            ? MediaQuery.of(context).size.width *
                                  0.04 // 4% of screen width
                            : MediaQuery.of(context).size.width *
                                  0.03, // 2% of screen width
                        vertical:
                            MediaQuery.of(context).size.height *
                            0.015, // 1.5% of screen height
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.orange : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _icons[index] is IconData
                              ? Icon(
                                  _icons[index],
                                  size:
                                      MediaQuery.of(context).size.width * 0.06,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.orange,
                                )
                              : Image.asset(
                                  _icons[index],
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                  height:
                                      MediaQuery.of(context).size.width * 0.06,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.orange,
                                ),
                          if (isSelected) ...[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _labels[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                        0.035,
                                  ),
                                ),
                                Text(
                                  "${_itemCount[index]} Items",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                        0.025,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: 20),

              //Menu Section
              Expanded(
                child: ListView.builder(
                  itemCount:
                      restaurantMenu.length, // use the dynamic list length
                  itemBuilder: (context, index) {
                    final item =
                        restaurantMenu[index]; // get each restaurant item

                    return MenuCard(
                      name: item['name'],
                      description: item['description'],
                      imageUrl: item['imageUrl'],
                      rating: double.parse(
                        item['rating'],
                      ), // convert string to double
                      time: item['time'],
                      orders: item['orders'],
                      price: item['price'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
