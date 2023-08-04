import 'package:dairy_products/data/models/post_buy_shell_model.dart';
import 'package:flutter/material.dart';

import 'buy_list_detail_form.dart';

class BuyListDetail extends StatelessWidget {
  const BuyListDetail({super.key,this.shellBuyBody});
 final ShellBuyBody? shellBuyBody;
  @override
  Widget build(BuildContext context) {
    return  BuyListDetailForm(shellBuyBody: shellBuyBody,);
  }
}