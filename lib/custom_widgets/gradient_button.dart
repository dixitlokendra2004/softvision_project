import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  GradientButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.blue.shade800], // Define your gradient colors
          begin: Alignment.centerLeft, // Adjust the gradient begin position
          end: Alignment.centerRight, // Adjust the gradient end position
        ),
        borderRadius: BorderRadius.circular(20), // Add rounded corners
      ),
      child: MaterialButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}