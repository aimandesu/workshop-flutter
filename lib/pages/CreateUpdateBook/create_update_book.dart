import 'package:book_app/model/book_model.dart';
import 'package:book_app/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateUpdateBookPage extends StatefulWidget {
  const CreateUpdateBookPage({super.key});

  @override
  State<CreateUpdateBookPage> createState() => _CreateUpdateBookPageState();
}

class _CreateUpdateBookPageState extends State<CreateUpdateBookPage> {
  //controllers
  final TextEditingController isbnController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  //variables
  int? _bookId;
  DateTime createdAt = DateTime.now();
  DateTime? updatedAt;
  bool _isInit = true;
  bool _isEdit = false;

  SnackBar snackbarToShow(String value) {
    return SnackBar(
      content: Text(value),
    );
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final dynamic bookModel = ModalRoute.of(context)!.settings.arguments;

      if (bookModel is BookModel) {
        _bookId = bookModel.id;
        isbnController.text = bookModel.isbn;
        nameController.text = bookModel.name;
        yearController.text = bookModel.year.toString();
        authorController.text = bookModel.author;
        descriptionController.text = bookModel.description;
        imageController.text = bookModel.image;
        createdAt = bookModel.createdAt;
        updatedAt = bookModel.updatedAt;
        _isEdit = true;
      }
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    isbnController.dispose();
    nameController.dispose();
    yearController.dispose();
    authorController.dispose();
    descriptionController.dispose();
    imageController.dispose();
    super.dispose();
  }

  void clearFields() {
    isbnController.clear();
    nameController.clear();
    yearController.clear();
    authorController.clear();
    descriptionController.clear();
    imageController.clear();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: createdAt,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != createdAt) {
      setState(() {
        createdAt = picked;
      });
    }
  }

  void _submitData() {
    BookModel bookModel = BookModel(
      id: _bookId,
      isbn: isbnController.text,
      name: nameController.text,
      year: int.parse(yearController.text),
      author: authorController.text,
      description: descriptionController.text,
      image: imageController.text,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );

    if (_isEdit) {
      context.read<DataProvider>().updateBook(bookModel);
      ScaffoldMessenger.of(context).showSnackBar(
        snackbarToShow("The book has been updated"),
      );
    } else {
      context.read<DataProvider>().createBook(bookModel);
      ScaffoldMessenger.of(context).showSnackBar(
        snackbarToShow("The book suggestion has been created"),
      );
      clearFields();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEdit ? 'Update Book' : 'Suggest Books',
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Colors.black87),
                    textInputAction: TextInputAction.next,
                    controller: isbnController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Isbn',
                      hintStyle: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Colors.black87),
                    textInputAction: TextInputAction.next,
                    controller: nameController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'name',
                      hintStyle: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Colors.black87),
                    textInputAction: TextInputAction.next,
                    controller: yearController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'year',
                      hintStyle: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Colors.black87),
                    textInputAction: TextInputAction.next,
                    controller: authorController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'author',
                      hintStyle: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Colors.black87),
                    controller: descriptionController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'description',
                      hintStyle: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    maxLines: 4,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Colors.black87),
                    textInputAction: TextInputAction.next,
                    controller: imageController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'image link',
                      hintStyle: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${createdAt.toLocal()}".split(' ')[0],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text(
                        'Select date',
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => _submitData(),
                    child: Text(_isEdit ? "Update" : "Create"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
