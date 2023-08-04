import 'package:dairy_products/common/widgets/text_style.dart';
import 'package:flutter/material.dart';

class ProductEnquiryWidget extends StatefulWidget {
  const ProductEnquiryWidget({super.key});

  @override
  State<ProductEnquiryWidget> createState() => _ProductEnquiryWidgetState();
}

class _ProductEnquiryWidgetState extends State<ProductEnquiryWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 97, 156),
        centerTitle: true,
        title: const Text("Product enquiry"),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(6),
          itemCount: 10,
          itemBuilder: (_, index) {
            return Card(
              elevation: 4,
              margin: const EdgeInsets.all(4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("ID : 12"),
                        ActionChip(
                          onPressed: () {},
                          labelPadding: const  EdgeInsets.only(left:16,right: 16),
                          autofocus: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          label: Text("Pending",
                              style: CommonStyles(context)
                                  .hintStyle(color: Colors.white,fontSize: 14)),
                          backgroundColor: const Color.fromARGB(255, 64, 157, 233),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Post ID",
                              style: CommonStyles(context)
                                  .hintStyle(color: Colors.grey,fontSize: 16),
                            ),
                            Text(
                              "45",
                              style: CommonStyles(context)
                                  .hintStyle(color: Colors.black,fontSize: 14),
                            ),
                            Text(
                              "Post type",
                              style: CommonStyles(context)
                                  .hintStyle(color: Colors.grey,fontSize: 16),
                            ),
                            Text(
                              "sell",
                              style: CommonStyles(context)
                                  .hintStyle(color: Colors.black,fontSize: 14),
                            ),
                            Text(
                              "Date",
                              style: CommonStyles(context)
                                  .hintStyle(color: Colors.grey,),
                            ),
                            Text(
                              "01/08/23",
                              style: CommonStyles(context)
                                  .hintStyle(color: Colors.black,fontSize: 14),
                            ),
                           
                            Text(
                              "Designation",
                              style: CommonStyles(context)
                                  .hintStyle(color: Colors.grey),
                            ),
                            Text(
                              "Chairman",
                              style: CommonStyles(context)
                                  .hintStyle(color: Colors.black,fontSize: 14),
                            ),
                            // InkWell(
                            //   onTap: () {},
                            //   child: Container(
                                
                            //     alignment: Alignment.center,
                            //     decoration: BoxDecoration(
                            //       color: Colors.green,
                            //       borderRadius: BorderRadius.circular(20)),
                            //     margin: const EdgeInsets.only(top: 5),
                            //     padding: const EdgeInsets.only(left:20,right: 20,top: 7,bottom: 7),
                            //     child:  Text("view message", style: CommonStyles(context)
                            //       .hintStyle(color: Colors.white),),
                            //   ),
                            // )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Product type",
                              style: CommonStyles(context)
                                  .hintStyle(color: Colors.grey,),
                            ),
                            Text(
                              "Bulk milk/ whole milk",
                              style: CommonStyles(context)
                                  .hintStyle(color: Colors.black,fontSize: 14),
                            ),
                            Text(
                              "My price",
                              style: CommonStyles(context)
                                  .hintStyle(color: Colors.grey),
                            ),
                            Text(
                              "\u{20B9}120",
                              style: CommonStyles(context)
                                  .hintStyle(color: Colors.black,fontSize: 14),
                            ),
                            Text(
                              "Offer price",
                              style: CommonStyles(context)
                                  .hintStyle(color: Colors.grey),
                            ),
                            Text(
                              "\u{20B9}100",
                              style: CommonStyles(context)
                                  .hintStyle(color: Colors.black,fontSize: 14),
                            ),
                            Text(
                              "Business name",
                              style: CommonStyles(context)
                                  .hintStyle(color: Colors.grey),
                            ),
                            Text(
                              "RK Dairy products",
                              style: CommonStyles(context)
                                  .hintStyle(color: Colors.black,fontSize: 14),
                            ),
                            // InkWell(
                            //   onTap: () {},
                            //   child: Container(
                            //     alignment: Alignment.center,
                            //     decoration: BoxDecoration(
                            //       border: Border.all(),
                            //       borderRadius: BorderRadius.circular(20)),
                            //       margin: const EdgeInsets.only(top: 5),
                            //     padding: const EdgeInsets.only(left:20,right: 20,top: 7,bottom: 7),
                            //     child:  Text("view product",style: CommonStyles(context)
                            //       .hintStyle(color: Colors.black),),
                            //   ),
                            // )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         InkWell(
                              onTap: () {},
                              child: Container(
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(20)),
                                  margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.only(left:8,right: 8,top: 7,bottom: 7),
                                child:  Text("view details",style: CommonStyles(context)
                                  .hintStyle(color: Colors.black,fontSize: 14),),
                              ),
                            ), Flexible(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                 
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(20)),
                                    margin: const EdgeInsets.only(top: 5),
                                  padding: const EdgeInsets.only(left:8,right: 8,top: 7,bottom: 7),
                                  child:  Text("view product",style: CommonStyles(context)
                                    .hintStyle(color: Colors.black,fontSize: 14),),
                                ),
                              ),
                            ), Flexible(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(), color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20)),
                                    margin: const EdgeInsets.only(top: 5),
                                  padding: const EdgeInsets.only(left:8,right: 8,top: 7,bottom: 7),
                                  child:  Text("view message",style: CommonStyles(context)
                                    .hintStyle(color: Colors.white,fontSize: 14),),
                                ),
                              ),
                            )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
