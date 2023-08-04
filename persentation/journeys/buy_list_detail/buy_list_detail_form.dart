import 'package:dairy_products/data/models/post_buy_shell_model.dart';
import 'package:flutter/material.dart';

class BuyListDetailForm extends StatefulWidget {
  const BuyListDetailForm({super.key,this.shellBuyBody});
  final ShellBuyBody? shellBuyBody;
  @override
  State<BuyListDetailForm> createState() => _BuyListDetailFormState();
}

class _BuyListDetailFormState extends State<BuyListDetailForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 97, 156),
        title: const Text('Buyer Detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.only(left: 8),
              margin: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(color: Colors.grey),
              child: const Text(
                "Product & Trader Information",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
 richTextWidget(text1: "Trader Name", text2: widget.shellBuyBody?.productName??''),
            const SizedBox(
              height: 10,
            ),
            richTextWidget(text1: "Trader Logo", text2: ""),
            const SizedBox(
              height: 10,
            ),
            richTextWidget(text1: "FAT", text2: widget.shellBuyBody?.fat??''),
            const SizedBox(
              height: 10,
            ),
            richTextWidget(text1: "Product Type", text2: widget.shellBuyBody?.productTypeName??''),
            const SizedBox(
              height: 10,
            ),
            richTextWidget(text1: "SNF", text2: widget.shellBuyBody?.snf??''),
            const SizedBox(
              height: 10,
            ),
            richTextWidget(text1: "MBRT", text2: widget.shellBuyBody?.mbrt??''),
            const SizedBox(
              height: 10,
            ),
            richTextWidget(text1: "Expecting Price (in litre)", text2: widget.shellBuyBody?.price??''),
            const SizedBox(
              height: 10,
            ),
            richTextWidget(text1: "Available Type", text2: widget.shellBuyBody?.avaiablequanitity??''),
            const SizedBox(
              height: 10,
            ),
            richTextWidget(text1: "Posted Date", text2: widget.shellBuyBody!.postCreatedDateTime!.toString()),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.only(left: 8),
              margin: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(color: Colors.grey),
              child: const Text(
                "Address",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 10,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget richTextWidget({required String text1, required String text2}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text1, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(text2, style: const TextStyle(fontWeight: FontWeight.normal))
        ],
      ),
    );
    // return RichText(
    //     text: TextSpan(children: [
    //   TextSpan(
    //       text: text1, style: const TextStyle(fontWeight: FontWeight.bold)),
    //   TextSpan(
    //       text: text2, style: const TextStyle(fontWeight: FontWeight.normal))
    // ]));
  }
}
