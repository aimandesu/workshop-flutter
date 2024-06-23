import 'package:book_app/model/book_model.dart';
import 'package:flutter/material.dart';

class BookShelf extends StatelessWidget {
  const BookShelf({
    super.key,
    required this.bookModel,
  });

  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 220,
      width: size.width * 1,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.green[100],
                boxShadow: const [
                  BoxShadow(
                    color: Colors.green,
                    blurRadius: 4,
                    offset: Offset(4, 8),
                  ),
                ],
              ),
              height: 160,
              width: size.width * 0.9,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  height: 160,
                  width: size.width * 0.5,
                  child: Text(
                    bookModel.description,
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Hero(
              tag: bookModel.id.toString(),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.green[300],
                ),
                height: 180,
                width: size.width * 0.4,
                child: Image.network(
                  bookModel.image,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
