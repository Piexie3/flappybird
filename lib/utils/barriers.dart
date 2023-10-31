import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final size;
  const MyBarrier({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(
            width: 8,
            color: Colors.green.shade200,
          ),
          borderRadius: const BorderRadius.all(
           Radius.circular(15),
          )),
    );
  }
}
