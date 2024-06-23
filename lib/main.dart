import 'package:book_app/model/book_model.dart';
import 'package:book_app/pages/BookDetailsPage/book_details_page.dart';
import 'package:book_app/pages/BooksPage/books_page.dart';
import 'package:book_app/pages/CreateUpdateBook/create_update_book.dart';
import 'package:book_app/pages/HomePage/home_page.dart';
import 'package:book_app/pages/LoginPage/login_page.dart';
import 'package:book_app/pages/SearchingPage/searching_page.dart';
import 'package:book_app/provider/data_provider.dart';
import 'package:book_app/provider/login_error_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/route_path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<int?> checkToken;

  Future<int?> checkUserHasToken() async {
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    final SharedPreferences sharedPreferences = await prefs;

    final int? token = (sharedPreferences.getInt('token'));
    return token;
  }

  @override
  void initState() {
    checkToken = checkUserHasToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginErrorProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book Theme',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        home: FutureBuilder(
          future: checkToken,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          },
        ),
        routes: {
          RoutePath.booksPage: (_) => const BooksPage(),
          RoutePath.searchingPage: (_) => const SearchingPage(),
          RoutePath.bookDetailsPage: (_) => BookDetailsPage(
                bookModel: BookModel.initial(),
              ),
          RoutePath.createUpdateBookPage: (_) => const CreateUpdateBookPage(),
          RoutePath.homePage: (_) => const HomePage(),
        },
      ),
    );
  }
}
