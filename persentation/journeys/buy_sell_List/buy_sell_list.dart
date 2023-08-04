import 'package:dairy_products/common/widgets/text_style.dart';
import 'package:dairy_products/persentation/journeys/buy_sell_List/buy_sell_list_detail.dart';
import 'package:flutter/material.dart';


class BuySellList extends StatelessWidget {
  const BuySellList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 97, 156),
        centerTitle: true,
        title: Text(
          "Product list",
          style: CommonStyles(context).appBarStyle(),
        ),
      ),
      body: const BuySellListDetail(),
      );
  }
}