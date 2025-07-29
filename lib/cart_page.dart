import 'package:deli_pos/component/cartItemCard.dart';
import 'package:deli_pos/filterData/filter_data.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double deleteButtonWidth = 30;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 35, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_circle_left_rounded,
                          color: Color(0xFFFF8C00),
                        ),
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, '/'),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Cart',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        cartLists.clear();
                      });
                    },
                  ),
                ],
              ),
            ),

            Expanded(
              child: SizedBox(
                height: 300,
                child: cartLists.isEmpty
                    ? const Center(child: Text('Cart is empty'))
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: cartLists.length,
                        itemBuilder: (context, index) {
                          final item = cartLists[index];
                          return ItemCard(
                            title: item['title'] ?? '',
                            subtitle: item['subtitle'] ?? '',
                            price:
                                int.tryParse(
                                  item['price'].toString().replaceAll(',', ''),
                                ) ??
                                0,
                            quantity: item['quantity'] ?? 1,
                            imagePath: item['imagePath'],
                            onIncrease: () {
                              setState(() {
                                cartLists[index]['quantity']++;
                              });
                            },
                            onDecrease: () {
                              setState(() {
                                if (cartLists[index]['quantity'] > 1) {
                                  cartLists[index]['quantity']--;
                                }
                              });
                            },
                            onDelete: () {
                              setState(() {
                                cartLists.removeAt(index);
                              });
                            },
                          );
                        },
                      ),
              ),
            ),

            //Promo code
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 3),
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Text(
                        "Promo code",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 28,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "Apply",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Subtotal & total
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 3),
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 25.0),
                            child: Text(
                              "Subtotal",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0xFF878787),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 25.0),
                            child: Text(
                              "37000 MMK",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 25.0),
                            child: Text(
                              "Total",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 25.0),
                            child: Text(
                              "35000 MMK",
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(11.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/confirmOrderPage');
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
                    child: Text(
                      'Order now',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
