import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Define the action to be performed on button press
          },
          focusColor: Colors.green,
          hoverColor: Colors.green,
          foregroundColor: Colors.green,
          backgroundColor: Colors.white,
          // shape: CircleBorder(), // Ensure the button is circular
          child: Container(
            padding: const EdgeInsets.all(5.0), // Adjust the padding as needed
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '12',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    color: Colors.black, // Adjust the text style as needed
                  ),
                ),
                const SizedBox(
                    height: 2), // Adjust spacing between text and image
                Expanded(
                  child: Image.asset(
                    'assets/images/veg_cart_icon.png', // Path to your image
                    fit: BoxFit
                        .contain, // Ensures the image fits within the button
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 222, 222, 222),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(0.0),
            child: Column(
              children: [
                for (int i = 0; i < 7; i++) _buildRow(i),
              ],
            ),
          ),
        ));
  }

  Widget _buildRow(int rowIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < 3; i++) _buildCard(rowIndex * 3 + i),
      ],
    );
  }

  Widget _buildCard(int index) {
    if (index >= 30) return const SizedBox(); // Handle overflow gracefully

    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 8.0), // Vertical spacing
            Image.asset('assets/images/product_image.png'),
            Text('Name'),
            Text('\$${index + 1.0}'), // Price with index for demonstration
          ],
        ),
      ),
    );
  }
}
