import 'package:book_app/pages/HomePage/widget/banner.dart';
import 'package:book_app/pages/route_path.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Discover'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed(
                RoutePath.searchingPage,
              ),
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.remove('token');
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: Column(
          children: [
            BannerWidget(
              title: 'Online',
              title2: 'Learning',
              optionTitle: 'View Books',
              imagePath: 'assets/images/book.png',
              optionAction: () => Navigator.pushNamed(
                context,
                RoutePath.booksPage,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BannerWidget(
              title: 'Suggest',
              title2: 'Books',
              optionTitle: 'Create Book',
              imagePath: 'assets/images/thinking.png',
              optionAction: () => Navigator.pushNamed(
                context,
                RoutePath.createUpdateBookPage,
              ),
            )
            //
          ],
        ),
      ),
    );
  }
}
