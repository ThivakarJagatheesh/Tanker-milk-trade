import 'package:dairy_products/data/models/post_buy_shell_model.dart';
import 'package:dairy_products/persentation/journeys/sell_list_detail/sell_list_detail_form.dart';
import 'package:flutter/material.dart';


class SellListDetail extends StatelessWidget {
  const SellListDetail({super.key,this.shellBuyBody});
final ShellBuyBody? shellBuyBody;
  @override
  Widget build(BuildContext context) {
    return  SellListDetailForm(shellBuyBody: shellBuyBody,);
  }
}