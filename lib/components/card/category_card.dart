import 'package:cloud_9_client/models/category.dart';
import 'package:flutter/material.dart';

typedef CategoryCardOnTap = Function();

class CategoryCard extends StatelessWidget {
  final Category category;
  final CategoryCardOnTap onTap;

  const CategoryCard({Key key, @required this.category, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        elevation: 2,
        child: Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
              color: category.isSelected ? Colors.deepOrange : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Image.asset(category.image, height: 40, width: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    
                    category.name,
                    style: TextStyle(
                        color: category.isSelected ? Colors.white : Colors.blue, fontSize: 15, fontWeight: FontWeight.bold ),
                        textAlign: TextAlign.center,
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
