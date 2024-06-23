import 'package:book_app/model/book_model.dart';
import 'package:book_app/pages/BookDetailsPage/book_details_page.dart';
import 'package:book_app/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchingPage extends StatefulWidget {
  const SearchingPage({super.key});

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  TextEditingController searchingController = TextEditingController();
  late Future<void> theSearchFuture;

  @override
  void initState() {
    theSearchFuture =
        Provider.of<DataProvider>(context, listen: false).initialiseBookData();
    super.initState();
  }

  @override
  void dispose() {
    searchingController.dispose();
    super.dispose();
  }

  void searching(BuildContext context) {
    Provider.of<DataProvider>(context, listen: false)
        .searchBook(searchingController.text);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.black54),
          backgroundColor: Colors.green[100],
        ),
        body: Container(
          width: size.width,
          height: size.height,
          color: Colors.green[100],
          child: Column(
            children: [
              Container(
                width: size.width * 0.9,
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.next,
                  controller: searchingController,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Searching',
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  onChanged: (value) {
                    searching(context);
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: theSearchFuture,
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
                          List<BookModel> result;

                          if (searchingController.text == '') {
                            result = dataProvider.books;
                          } else {
                            result = dataProvider.searchesBook;
                          }

                          return ListView.builder(
                            itemCount: result.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BookDetailsPage(
                                        bookModel: result[index],
                                      ),
                                    ),
                                  );
                                },
                                title: Text(
                                  result[index].name.toString(),
                                  style: const TextStyle(color: Colors.black87),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
