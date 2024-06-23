import 'package:book_app/model/book_model.dart';
import 'package:book_app/pages/BookDetailsPage/book_details_page.dart';
import 'package:book_app/pages/BooksPage/widget/books_shelf.dart';
import 'package:book_app/pages/route_path.dart';
import 'package:book_app/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  late Future<void> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture =
        Provider.of<DataProvider>(context, listen: false).initialiseBookData();
  }

  Future<void> _buildDialogOption(
    BuildContext context,
    BookModel bookModel,
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Options'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Delete Book'),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<DataProvider>().deleteBook(bookModel.id!);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Update Book'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(
                  RoutePath.createUpdateBookPage,
                  arguments: bookModel,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book List'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<DataProvider>().listingAscendingOrder();
            },
            icon: const Icon(Icons.filter_vintage),
          )
        ],
      ),
      body: FutureBuilder(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Consumer<DataProvider>(
              builder: (context, dataProvider, child) {
                final result = dataProvider.books;

                if (result.isEmpty) {
                  return const Center(child: Text('No books available'));
                }

                return ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BookDetailsPage(
                              bookModel: result[index],
                            ),
                          ),
                        );
                      },
                      onLongPress: () {
                        _buildDialogOption(context, result[index]);
                      },
                      child: BookShelf(
                        bookModel: result[index],
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
