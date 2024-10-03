import 'package:flutter/material.dart';
import 'package:list_scrollable_tabs/models/product_category.dart';

import '../sushi_bloc.dart';

class SushiCategoryItem extends StatelessWidget {
  const SushiCategoryItem({super.key, required this.category});
  final ProductCategory? category;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: categoryHeight,
      alignment: Alignment.centerLeft,
      child: Text(
        category?.name ?? "",
        style:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );

  }
}

