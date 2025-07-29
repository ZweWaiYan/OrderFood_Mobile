import 'package:flutter/material.dart';

class Floatingbtn extends StatelessWidget {
  const Floatingbtn({super.key});

  void _doAction() {
    print("Do Action");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: _doAction,
              tooltip: 'doAction',
              child: const Icon(Icons.add_alarm),
            ),
          ),
        )
      ],
    );
  }
}
