import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_scrollable_tabs/models/product_category.dart';

import '../sushi_bloc.dart';


class SushiProductItem extends StatelessWidget {
  const SushiProductItem({super.key, required this.product});
  final Product? product;

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: productHeight,
        child: Card(
            elevation: 6,
            color: Colors.transparent,
            shadowColor: Colors.white10,

            margin: const EdgeInsets.symmetric(vertical: 6.0), //
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 35, bottom: 35, right: 10
                  ),
                  child: Image.asset(
                      product?.image ?? ""
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product?.name ?? ""
                        ,style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold

                      ),),
                      const SizedBox(height: 6.0,),
                      Text(
                        product?.description ?? "",
                        maxLines: 4,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 6.0,),
                      Text(
                          product?.price ?? "",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
