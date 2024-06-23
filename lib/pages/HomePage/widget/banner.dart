import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    required this.title,
    required this.title2,
    required this.optionTitle,
    required this.imagePath,
    required this.optionAction,
  });

  final String title;
  final String title2;
  final String optionTitle;
  final String imagePath;
  final VoidCallback optionAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.green[100],
          boxShadow: const [
            BoxShadow(
              color: Colors.green,
              blurRadius: 4,
              offset: Offset(4, 8), // Shadow position
            ),
          ],
        ),
        width: size.width * 0.9,
        height: 150,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Text(
                '$title \n$title2',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: GestureDetector(
                onTap: optionAction,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green[800],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    optionTitle,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 20,
              child: Image.asset(
                imagePath,
                height: 100,
              ),
            )
          ],
        ),
      ),
    );
  }
}
