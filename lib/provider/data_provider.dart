import 'dart:convert';
import 'dart:developer';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/provider/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  List<BookModel> _books = [];
  List<BookModel> _searchesBook = [];

  List<BookModel> get books => _books;
  List<BookModel> get searchesBook => _searchesBook;

  Future<void> initialiseBookData() async {
    final response = await http.get(
      Uri.parse("$WEB_URL/get_books.php"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      log('data retrieved');
      _books = json
          .map((book) => BookModel.fromMap(book as Map<String, dynamic>))
          .toList();

      notifyListeners();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<void> listingAscendingOrder() async {
    final response = await http.get(
      Uri.parse("$WEB_URL/get_books.php?order=name&orderType=ASC"),
    );
    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      log('data retrieved');
      _books = json
          .map((book) => BookModel.fromMap(book as Map<String, dynamic>))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<void> createBook(BookModel bookModel) async {
    final response = await http.post(
      Uri.parse("$WEB_URL/create_book.php"),
      headers: {"Content-Type": "application/json"},
      body: bookModel.toJson(),
    );

    if (response.statusCode == 200) {
      log('Book data sent successfully!');

      notifyListeners();
    } else {
      throw Exception('Failed to create book');
    }
  }

  Future<void> updateBook(BookModel bookModel) async {
    final url = Uri.parse('$WEB_URL/update_book.php');
    final response = await http.post(
      url,
      body: bookModel.toJson(),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      log('Book updated successfully!');
      final index =
          _books.indexWhere((existingBook) => existingBook.id == bookModel.id);

      if (index != -1) {
        _books[index] = bookModel;

        notifyListeners();
      } else {
        log('Book with ID ${bookModel.id} not found in the list');
      }
    } else {
      log('Error updating book: ${response.statusCode}');
    }
  }

  Future<void> deleteBook(int id) async {
    final url = Uri.parse('$WEB_URL/delete_book.php');
    final response = await http.post(
      url,
      body: jsonEncode({'id': id}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      log('Book deleted');
      _books.removeWhere((element) => element.id == id);
      notifyListeners();
    } else {
      // Handle error
      log('Error deleting book: ${response.statusCode}');
    }
  }

  Future<void> searchBook(String keyword) async {
    _searchesBook = books
        .where(
          (element) =>
              element.name.toLowerCase().contains(keyword.toLowerCase()),
        )
        .toList();
    notifyListeners();
  }
}
