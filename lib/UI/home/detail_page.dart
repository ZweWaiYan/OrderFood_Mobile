import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:deli_pos/filterData/filter_data.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playVoice() async {
    await audioPlayer.play(AssetSource('audio/pizza.mp3'));
  }

  int _quantity = 1;
  int _selectedSizeIndex = 0;
  final int _pricePerItem = 10500;

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (_quantity > 1) _quantity--;
    });
  }

  List<bool> ingredientSelected = List.generate(
    ingredientsLists.length,
    (_) => false,
  );

  @override
  Widget build(BuildContext context) {
    int totalPrice = _quantity * _pricePerItem;
    final docSnapshot =
        ModalRoute.of(context)!.settings.arguments as QueryDocumentSnapshot;
    final data = docSnapshot.data() as Map<String, dynamic>;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushNamed(context, '/');
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 35, 10, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_circle_left_rounded,
                      color: Color(0xFFFF8C00),
                    ),
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/'),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.amber,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),

              // Fixed section at the top
              Hero(
                tag: data['name'],
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    // child: Image.asset(
                    //   'assets/pizza.png',
                    //   height: 200,
                    //   width: double.infinity,
                    //   fit: BoxFit.cover,
                    // ),
                    child: Image.network(
                      data['imageUrl'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      // child: Text(
                      //   "Burger With Meat",
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      child: Text(
                        data['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      icon: const Icon(Icons.volume_up, size: 26),
                      onPressed: playVoice,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 3),

              // Price
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  // child: Text(
                  //   "10,500 Ks",
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     color: Colors.orange,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  child: Text(
                    "${data['price']} Ks",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 7),

              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(193, 255, 222, 179),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/bag.png',
                              width: 20,
                              height: 20,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 7),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: const Text(
                                "7000+ Order",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 130, 130, 130),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.access_time_outlined,
                              color: Colors.orange,
                              size: 22,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "20 - 30",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 130, 130, 130),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 22),
                            SizedBox(width: 5),
                            Text(
                              "4.5",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 130, 130, 130),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: ListView(
                  children: [
                    // Description Title
                    const Padding(
                      padding: EdgeInsets.fromLTRB(13, 0, 13, 10),
                      child: Text(
                        "Description",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    // Description Text
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      // child: Text(
                      //   "Burger With Meat is a typical food from our restaurant that is much in demand by many people. This is very recommended for you.",
                      //   style: TextStyle(
                      //     color: Color.fromARGB(255, 130, 130, 130),
                      //     fontFamily: 'Roboto',
                      //   ),
                      // ),
                      child: Text(
                        data['description'],
                        style: TextStyle(
                          color: Color.fromARGB(255, 130, 130, 130),
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Product Title
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        "Product Description",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    // Product Desccription
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        maxLines: 4, // Allow 4 lines of text
                        decoration: InputDecoration(
                          hintText: 'Write your message...',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Size List
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 12, right: 8),
                            child: Text(
                              "Size :",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sizeLists.length,
                                itemBuilder: (context, index) {
                                  final isSelected =
                                      _selectedSizeIndex == index;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedSizeIndex = isSelected
                                            ? -1
                                            : index;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.orange
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 5,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          sizeLists[index],
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Main Ingredients
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        "Main Ingredients",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //Ingredient Lists
                    ListView.builder(
                      itemCount: ingredientsLists.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final ingredient = ingredientsLists[index];
                        return SizedBox(
                          height: 60,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            padding: const EdgeInsets.only(right: 9),
                            decoration: BoxDecoration(
                              color: Colors.white, // Background color
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // Shadow position
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    ingredient['image']!,
                                    width: 90,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  ingredient['name']!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                IconButton(
                                  icon: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: ingredientSelected[index]
                                          ? const Color(0xFFFE8C00)
                                          : const Color(0xFFFBEFDC),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      ingredientSelected[index]
                                          ? Icons.check
                                          : Icons.add,
                                      color: ingredientSelected[index]
                                          ? Colors.white
                                          : const Color(0xFFFE8C00),
                                      size: 18,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      ingredientSelected[index] =
                                          !ingredientSelected[index];
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    // Qty & Total Price
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: _decrement,
                                    icon: const Icon(Icons.remove, size: 19),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '$_quantity',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  IconButton(
                                    onPressed: _increment,
                                    icon: const Icon(Icons.add, size: 19),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: Text(
                                  '$totalPrice MMK',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/cartPage');
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Add to Cart',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
