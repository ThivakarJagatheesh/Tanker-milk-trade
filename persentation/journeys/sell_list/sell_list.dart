import 'package:dairy_products/common/widgets/text_style.dart';
import 'package:dairy_products/data/models/post_buy_shell_model.dart';
import 'package:dairy_products/di/get_it.dart';
import 'package:dairy_products/persentation/bloc/product/product_bloc.dart';
import 'package:dairy_products/persentation/bloc/product/product_state.dart';
import 'package:dairy_products/persentation/journeys/sell_list_detail/sell_list_detail.dart';

import 'package:dairy_products/persentation/journeys/sell_post/sell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SellListWidget extends StatefulWidget {
  const SellListWidget({super.key});

  @override
  State<SellListWidget> createState() => _SellListWidgetState();
}

class _SellListWidgetState extends State<SellListWidget> {
  late ProductBloc productBloc;
  List<ShellBuyBody> shellBuyBody = [];
  @override
  void initState() {
    super.initState();

    productBloc = getItInstance<ProductBloc>();
    productBloc.getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 97, 156),
        centerTitle: true,
        title: Text(
          "To Sell Post",
          style: CommonStyles(context).appBarStyle(),
        ),
      ),
      body: BlocProvider.value(
          value: productBloc,
          child: BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
            if (state is ProductListState) {
              for (var shell in state.shellBuyModel.body!) {
                if (shell.postType == "SELL") {
                  shellBuyBody.add(shell);
                }
                // } else {
                //   buyBody.add(shell);
                // }
              }
            }
          }, builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 24, 97, 156),
                ),
              );
            }
            return sellList(shellBuyBody);
          })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 24, 97, 156),
        onPressed: () {
          var route = MaterialPageRoute(builder: (_) => const SellPostPage());
          Navigator.push(context, route).whenComplete(() => productBloc.getProductList());
        },
        child: const Icon(Icons.add,),
      ),
    );
  }

  Widget sellList(List<ShellBuyBody> sell) {
    return ListView.separated(
        itemBuilder: (_, index) {
          return 
         Card(
                        color: Colors.white,
                        margin: const EdgeInsets.all(2.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          margin: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                                     Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Container(
                      //   width: 120,
                      //   height: 100,
                      //   color: Colors.white,
                      //   child: Image.asset(
                      //     "assests/whole-milk.jpg",
                      //     height: 100,
                      //     width: 80,
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Product type",
                            style: CommonStyles(context).hintStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            shellBuyBody[index].productTypeName ?? 'BULK MILK',
                            style: CommonStyles(context)
                                .hintStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            "Milk type",
                            style: CommonStyles(context)
                                .hintStyle(color: Colors.grey),
                          ),
                          Text(
                            shellBuyBody[index].subProducttypeName ?? '',
                            style: CommonStyles(context)
                                .hintStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            "Post valid till",
                            style: CommonStyles(context)
                                .hintStyle(color: Colors.grey),
                          ),
                          Text(
                            shellBuyBody[index].postExpiredDateTime != null
                                ? DateFormat("dd/MMM/yy").format(
                                    shellBuyBody[index].postExpiredDateTime!)
                                : '-',
                            style: CommonStyles(context)
                                .hintStyle(color: Colors.black, fontSize: 14),
                          ),
                          // Text(
                          //   "Business name",
                          //   style: CommonStyles(context)
                          //       .hintStyle(color: Colors.grey),
                          // ),
                          // Text(
                          //   "RK Dairy products",
                          //   style: CommonStyles(context)
                          //       .hintStyle(color: Colors.black,fontSize: 14),
                          // ),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Post type",
                            style: CommonStyles(context).hintStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            shellBuyBody[index].postType ?? '',
                            style: CommonStyles(context)
                                .hintStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            "Req Qty",
                            style: CommonStyles(context)
                                .hintStyle(color: Colors.grey),
                          ),
                          Text(
                            shellBuyBody[index].avaiablequanitity ?? '',
                            style: CommonStyles(context)
                                .hintStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            "Preferred Location",
                            style: CommonStyles(context)
                                .hintStyle(color: Colors.grey),
                          ),
                          Text(
                            'Thanjavur',
                            style: CommonStyles(context)
                                .hintStyle(color: Colors.black, fontSize: 14),
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
                      
                         
                              // Row(
                              //   children: [
                              //     // Container(
                              //     //   width: 120,
                              //     //   height: 100,
                              //     //   color: Colors.white,
                              //     //   child: Image.asset(
                              //     //     "assests/whole-milk.jpg",
                              //     //     height: 100,
                              //     //     width: 80,
                              //     //     fit: BoxFit.fill,
                              //     //   ),
                              //     // ),
                              //     const SizedBox(width: 10),
                              //     Expanded(
                              //         child: Column(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       mainAxisSize: MainAxisSize.max,
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         RichText(
                              //             text: TextSpan(children: [
                              //           const TextSpan(
                              //               text: "Category : ",
                              //               style:
                              //                   TextStyle(color: Colors.grey)),
                              //           TextSpan(
                              //               text: shellBuyBody[index]
                              //                       .productTypeName ??
                              //                   'BULK MILK',
                              //               style: const TextStyle(
                              //                   color: Colors.black)),
                              //         ])),
                              //         const SizedBox(
                              //           height: 5,
                              //         ),
                              //         RichText(
                              //             text: TextSpan(children: [
                              //           const TextSpan(
                              //               text: "Milk type : ",
                              //               style:
                              //                   TextStyle(color: Colors.grey)),
                              //           TextSpan(
                              //               text: shellBuyBody[index]
                              //                       .subProducttypeName ??
                              //                   '',
                              //               style: const TextStyle(
                              //                   color: Colors.black)),
                              //         ])),
                              //         const SizedBox(
                              //           height: 5,
                              //         ),
                              //         RichText(
                              //             text: TextSpan(children: [
                              //           const TextSpan(
                              //               text: "Quantity : ",
                              //               style:
                              //                   TextStyle(color: Colors.grey)),
                              //           TextSpan(
                              //               text: shellBuyBody[index]
                              //                       .avaiablequanitity ??
                              //                   '',
                              //               style: const TextStyle(
                              //                   color: Colors.black)),
                              //         ])),
                              //         const SizedBox(
                              //           height: 5,
                              //         ),
                              //         RichText(
                              //             text: const TextSpan(children: [
                              //           TextSpan(
                              //               text: "Location : ",
                              //               style:
                              //                   TextStyle(color: Colors.grey)),
                              //           TextSpan(
                              //               text: "Thanjavur",
                              //               style:
                              //                   TextStyle(color: Colors.black)),
                              //         ])),
                              //         const SizedBox(
                              //           height: 5,
                              //         ),
                              //         RichText(
                              //             text: TextSpan(children: [
                              //           const TextSpan(
                              //               text: "Post Type : ",
                              //               style:
                              //                   TextStyle(color: Colors.grey)),
                              //           TextSpan(
                              //               text:
                              //                   shellBuyBody[index].postType ??
                              //                       '',
                              //               style: const TextStyle(
                              //                   color: Colors.black)),
                              //         ])),
                              //         const SizedBox(
                              //           height: 10,
                              //         ),
                              //         Container(
                              //             margin:
                              //                 const EdgeInsets.only(right: 50),
                              //             decoration: BoxDecoration(
                              //               borderRadius:
                              //                   BorderRadius.circular(4.0),
                              //               color: const Color.fromARGB(
                              //                   255, 20, 80, 129),
                              //               // gradient:
                              //               //     const LinearGradient(
                              //               //         begin:
                              //               //             Alignment.topLeft,
                              //               //         end: Alignment
                              //               //             .bottomRight,
                              //               //         colors: [
                              //               //    Color.fromRGBO(138, 197, 245, 1)45),
                              //               //       Color.fromARGB(
                              //               //           255, 20, 80, 129),
                              //               //     ])
                              //             ),
                              //             width:
                              //                 MediaQuery.sizeOf(context).width,
                              //             padding: const EdgeInsets.all(8),
                              //             alignment: Alignment.center,
                              //             child: InkWell(
                              //                 onTap: () {
                              //                   // Navigator.pop(context);
                              //                   var route = MaterialPageRoute(
                              //                       builder: (context) =>
                              //                           SellListDetail(
                              //                             shellBuyBody:
                              //                                 shellBuyBody[
                              //                                     index],
                              //                           ));
                              //                   Navigator.push(context, route);
                              //                   // popupWidget(
                              //                   //   nameController: name,
                              //                   //   contactController:
                              //                   //       contact,
                              //                   //   onPressed: () {
                              //                   //     Navigator.pop(context);
                              //                   //     var route =
                              //                   //         MaterialPageRoute(
                              //                   //             builder:
                              //                   //                 (context) =>
                              //                   //                     SellListDetail(
                              //                   //                       shellBuyBody:
                              //                   //                           shellBuyBody[index],
                              //                   //                     ));
                              //                   //     Navigator.of(context)
                              //                   //         .push(route);
                              //                   //   },
                              //                   // );
                              //                 },
                              //                 child: Text(
                              //                   'View More',
                              //                   style: CommonStyles(context)
                              //                       .style(color: Colors.white),
                              //                 ))),
                              //       ],
                              //     ))
                              //   ],
                              // ),
                            ],
                          ),
                          const SizedBox(height: 10),
                           Container(
                              margin: const EdgeInsets.only(right: 50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: const Color.fromARGB(255, 20, 80, 129),
                                // gradient:
                                //     const LinearGradient(
                                //         begin:
                                //             Alignment.topLeft,
                                //         end: Alignment
                                //             .bottomRight,
                                //         colors: [
                                //    Color.fromRGBO(138, 197, 245, 1)45),
                                //       Color.fromARGB(
                                //           255, 20, 80, 129),
                                //     ])
                              ),
                              width: MediaQuery.sizeOf(context).width,
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              child: InkWell(
                                  onTap: () {
                                    // Navigator.pop(context);
                                    var route = MaterialPageRoute(
                                        builder: (context) => SellListDetail(
                                              shellBuyBody: shellBuyBody[index],
                                            ));
                                    Navigator.push(context, route);
                                    // popupWidget(
                                    //   nameController: name,
                                    //   contactController:
                                    //       contact,
                                    //   onPressed: () {
                                    //     Navigator.pop(context);
                                    //     var route =
                                    //         MaterialPageRoute(
                                    //             builder:
                                    //                 (context) =>
                                    //                     SellListDetail(
                                    //                       shellBuyBody:
                                    //                           shellBuyBody[index],
                                    //                     ));
                                    //     Navigator.of(context)
                                    //         .push(route);
                                    //   },
                                    // );
                                  },
                                  child: Text(
                                    'View More',
                                    style: CommonStyles(context)
                                        .style(color: Colors.white),
                                  ))),
                        ]),
         ));
        },
        separatorBuilder: (_, index) {
          return const Divider();
        },
        itemCount: sell.length);
  }
}
