import 'package:cloud_9_client/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
        body: SafeArea(
            child: _categoryProvider.availableCategories.isEmpty
                ? CircularProgressIndicator()
                : Container(
                    padding: EdgeInsets.only(top: 200, bottom: 200),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.check_box_outline_blank),
                          title: Text('DATA'),
                        );
                      },
                      itemCount: _categoryProvider.availableCategories.length,
                    ),
                  )));
  }
}
