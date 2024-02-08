import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  // Define onTap and text arguments into the class
  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    // Use the GestureDetector as the return value
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        // Uded the decoration function to decorate the button
        decoration: BoxDecoration(
          color: Color(0xFF004CFF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            // Here we used the text argument
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
