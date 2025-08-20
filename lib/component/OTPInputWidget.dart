import 'package:flutter/material.dart';

class OTPInputWidget extends StatelessWidget {
  final int length;
  final List<TextEditingController> controllers;

  OTPInputWidget({super.key, this.length = 5})
    : controllers = List.generate(length, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(length, (index) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: TextField(
              controller: controllers[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty && index < length - 1) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty && index > 0) {
                  FocusScope.of(context).previousFocus();
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
