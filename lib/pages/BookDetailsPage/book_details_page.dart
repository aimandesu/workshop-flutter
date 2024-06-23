import 'package:book_app/model/book_model.dart';
import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  const BookDetailsPage({
    super.key,
    required this.bookModel,
  });

  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width * 1,
        height: size.height * 1,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 20,
              right: 10,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height * 0.77,
                width: size.width * 1,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  color: Colors.green[100],
                ),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Text(
                        bookModel.author,
                        style: const TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        bookModel.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TabBar(
                        unselectedLabelColor: Colors.black,
                        dividerColor: Colors.transparent,
                        tabs: [
                          Tab(
                            text: "About Books",
                          ),
                          Tab(
                            text: "Description",
                          ),
                        ],
                      ),
                      Flexible(
                        child: SizedBox(
                          width: size.width * 1,
                          child: TabBarView(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...{
                                      "ID: ${bookModel.id}",
                                      "ISBN: ${bookModel.isbn}",
                                      "YEAR: ${bookModel.year}",
                                    }
                                        .map(
                                          (e) => Container(
                                            padding: const EdgeInsets.all(5),
                                            margin: const EdgeInsets.all(5),
                                            // height: 30,
                                            // width: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.green,
                                            ),
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList()
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Descripton",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      bookModel.description,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100,
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
      ),
    );
  }
}
