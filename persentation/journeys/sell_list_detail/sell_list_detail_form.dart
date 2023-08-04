import 'package:dairy_products/common/widgets/text_form_field_widget.dart';
import 'package:dairy_products/common/widgets/text_style.dart';
import 'package:dairy_products/data/models/post_buy_shell_model.dart';
import 'package:flutter/material.dart';

class SellListDetailForm extends StatefulWidget {
  const SellListDetailForm({super.key, this.shellBuyBody});
  final ShellBuyBody? shellBuyBody;
  @override
  State<SellListDetailForm> createState() => _SellListDetailFormState();
}

class _SellListDetailFormState extends State<SellListDetailForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MaterialButton(
        color: Colors.green,
        onPressed: () {
          popupWidget(
              nameController: nameController,
              contactController: contactController,
              onPressed: () {});
        },
        child: Text(
          "Chat with seller",
          style: CommonStyles(context).buttonStyle(color: Colors.white),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 97, 156),
        title: const Text('Seller Detail'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.shellBuyBody!.prductImage == null
                  ? Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                widget.shellBuyBody!.prductImage!)),
                      ),
                    )
                  : Container(
                      width: 150,
                      height: 100,
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: const BoxDecoration(
                        //  color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage("assests/taknerlogo.jpg")),
                      ),
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Whole Milk - Bulk Milk",
                    style:
                        CommonStyles(context).buttonStyle(color: Colors.black),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 4,
                    height: 4,
                  ),
                  richTextWidget(
                      text1: '\u{20B9}${widget.shellBuyBody?.price ?? ""}',
                      color: Colors.red)
                ],
              )
            ],
          ),
          const Text(
            "     Details",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        richTextWidget(
                            text1: "Post published", color: Colors.grey),
                        richTextWidget(
                            text1: "Post valid till", color: Colors.grey),
                        richTextWidget(text1: "Location", color: Colors.grey),
                        richTextWidget(text1: "Category", color: Colors.grey),
                        richTextWidget(
                            text1: "Product name", color: Colors.grey),
                        richTextWidget(text1: "Available", color: Colors.grey),
                        richTextWidget(text1: "Quantity", color: Colors.grey),
                        richTextWidget(
                            text1: "Expecting Doc", color: Colors.grey),
                        richTextWidget(text1: "FAT", color: Colors.grey),
                        richTextWidget(text1: "SNF", color: Colors.grey),
                        richTextWidget(text1: "MBRT", color: Colors.grey),
                        richTextWidget(text1: "CLR", color: Colors.grey),
                        richTextWidget(
                            text1: "Age of milk", color: Colors.grey),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        richTextWidget(text1: ":", color: Colors.grey),
                        richTextWidget(text1: ":", color: Colors.grey),
                        richTextWidget(text1: ":", color: Colors.grey),
                        richTextWidget(text1: ":", color: Colors.grey),
                        richTextWidget(text1: ":", color: Colors.grey),
                        richTextWidget(text1: ":", color: Colors.grey),
                        richTextWidget(text1: ":", color: Colors.grey),
                        richTextWidget(text1: ":", color: Colors.grey),
                        richTextWidget(text1: ":", color: Colors.grey),
                        richTextWidget(text1: ":", color: Colors.grey),
                        richTextWidget(text1: ":", color: Colors.grey),
                        richTextWidget(text1: ":", color: Colors.grey),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        richTextWidget(
                            text1:
                                "${widget.shellBuyBody?.postCreatedDateTime ?? ''}",
                            color: Colors.black),
                        richTextWidget(
                            text1:
                                "${widget.shellBuyBody?.postExpiredDateTime ?? ''}",
                            color: Colors.black),
                        richTextWidget(text1: "Thanjavur", color: Colors.black),
                        richTextWidget(
                            text1:
                                widget.shellBuyBody?.productType ?? 'Bulk Milk',
                            color: Colors.black),
                        richTextWidget(
                            text1: widget.shellBuyBody?.productName ??
                                'Whole milk',
                            color: Colors.black),
                        richTextWidget(
                            text1: widget.shellBuyBody?.productType ?? '',
                            color: Colors.black),
                        richTextWidget(
                            text1: widget.shellBuyBody?.avaiablequanitity ?? '',
                            color: Colors.black),
                        richTextWidget(
                            text1: widget.shellBuyBody?.price ?? '',
                            color: Colors.black),
                        richTextWidget(
                            text1: widget.shellBuyBody?.fat ?? '',
                            color: Colors.black),
                        richTextWidget(
                            text1: widget.shellBuyBody?.snf ?? '',
                            color: Colors.black),
                        richTextWidget(
                            text1: widget.shellBuyBody?.mbrt ?? '',
                            color: Colors.black),
                        richTextWidget(
                            text1:
                                widget.shellBuyBody?.subProducttypeName ?? '',
                            color: Colors.black),
                        richTextWidget(
                            text1: widget.shellBuyBody?.ageOfMilk ?? '',
                            color: Colors.black),
                      ])
                ]),
          ),
        ],
      ),
    );
  }

  Widget richTextWidget({required String text1, required Color color}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(text1,
          style: CommonStyles(context).textFormFieldStyle(color: color)),
    );
  }

  popupWidget(
      {required TextEditingController nameController,
      required TextEditingController contactController,
      required void Function()? onPressed}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Contact form"),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: const Color.fromARGB(255, 24, 97, 156),
                child:
                    const Text("cancel", style: TextStyle(color: Colors.white)),
              ),
              MaterialButton(
                onPressed: onPressed,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: const Color.fromARGB(255, 24, 97, 156),
                child:
                    const Text("Send", style: TextStyle(color: Colors.white)),
              ),
            ],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: IconButton(
                  //       onPressed: () {
                  //         Navigator.of(context).pop();
                  //         contactController.clear();
                  //         nameController.clear();
                  //       },
                  //       icon: const Icon(Icons.close)),
                  // ),
                  TextFormFieldWidgets(
                      controller: nameController, hintText: "Expecting price"),
                  TextFormFieldWidgets(
                    maxlines: 10,
                    controller: contactController,
                    hintText: "comments",
                    keyboardType: TextInputType.multiline,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
