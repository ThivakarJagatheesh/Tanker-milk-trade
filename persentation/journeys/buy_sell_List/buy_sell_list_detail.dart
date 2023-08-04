import 'package:carousel_slider/carousel_slider.dart';
import 'package:dairy_products/common/widgets/text_form_field_widget.dart';
import 'package:dairy_products/common/widgets/text_style.dart';
import 'package:dairy_products/data/models/post_buy_shell_model.dart';
import 'package:dairy_products/di/get_it.dart';
import 'package:dairy_products/persentation/bloc/product/product_bloc.dart';
import 'package:dairy_products/persentation/bloc/product/product_state.dart';
import 'package:dairy_products/persentation/journeys/buy_post/buy.dart';
import 'package:dairy_products/persentation/journeys/sell_list_detail/sell_list_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuySellListDetail extends StatefulWidget {
  const BuySellListDetail({super.key});

  @override
  State<BuySellListDetail> createState() => _BuySellListDetailState();
}

class _BuySellListDetailState extends State<BuySellListDetail>
    with TickerProviderStateMixin {
  late TabController controller;
  var name = TextEditingController();
  var contact = TextEditingController();
  late ProductBloc productBloc;
  List<ShellBuyBody> shellBuyBody = [];
  var searchController = TextEditingController();
  List<Widget> image = [
    Image.asset(
      "assests/taknerlogo.jpg",
      fit: BoxFit.fill,
    ),
    Image.asset(
      "assests/taknerlogo.jpg",
      fit: BoxFit.fill,
    ),
    Image.asset(
      "assests/taknerlogo.jpg",
      fit: BoxFit.fill,
    ),
  ];
  int current = 0;
  List<int> index = [];
  //List<ShellBuyBody> buyBody = [];
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    productBloc = getItInstance<ProductBloc>();
    getIndex();
    productBloc.getProductList();
  }

  getIndex() {
    for (var i = 0; i <= image.length; i++) {
      index.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 24, 97, 156),
      //   toolbarHeight: 40.0,
      //   title: const Text("Buy Sell List"), bottomOpacity: 0.8,
      //   centerTitle: true,
      // leading:const Icon(Icons.home),
      // title: const Text("Home"),
      // bottom: TabBar(
      //   controller: controller,
      //   indicatorWeight: 0.1,
      //   labelStyle: const TextStyle(fontSize: 16),
      //   padding: const EdgeInsets.all(8.0),
      //   tabs: const [Text("Buy List"), Text("Sell List")],
      // ),

      body: BlocProvider.value(
        value: productBloc,
        child:
            BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
          if (state is ProductListState) {
            for (var shell in state.shellBuyModel.body!) {
              shellBuyBody.add(shell);
              // if (shell.postType == "SELL") {
              //   shellBody.add(shell);
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
          return Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width/2+140,
                    child: TextFormFieldWidgets(
                      controller: searchController,
                      hintText: "search area,district...",
                      suffixIcon: const Icon(Icons.search),
                    ),
                  ),
                  PopupMenuButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    icon: const Icon(Icons.filter_list),
                    itemBuilder: (_) {
                    return [
                    const PopupMenuItem(child: Text("seller")),
                    const PopupMenuItem(child: Text("buyer")),
                      const PopupMenuItem(child: Text("category")),
                     const PopupMenuItem(child: Text("sub category")),
                      const PopupMenuItem(child: Text("location")), 
                    ];
                  })
                ],
              ),

              CarouselSlider.builder(
                  itemBuilder: (context, index, realIndex) {
                    return SizedBox(
                      // margin: const EdgeInsets.all(2),
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height,
                      child: Card(child: image[index]),
                    );
                  },
                  itemCount: image.length,
                  options: CarouselOptions(
                    height: 150,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.9,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.6,
                    onPageChanged: (i, _) {
                      setState(() {
                        current = i;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                  )),
              SizedBox(
                  height: 30,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: index.map((e) {
                        return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    current == e ? Colors.black : Colors.grey));
                      }).toList())),

              Expanded(
                child: ListView.separated(
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
                                children: [
                                  Container(
                                    width: 120,
                                    height: 100,
                                    color: Colors.white,
                                    child: Image.asset(
                                      "assests/whole-milk.jpg",
                                      height: 100,
                                      width: 80,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                          text: TextSpan(children: [
                                        const TextSpan(
                                            text: "Category : ",
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        TextSpan(
                                            text: shellBuyBody[index]
                                                    .productTypeName ??
                                                'BULK MILK',
                                            style: const TextStyle(
                                                color: Colors.black)),
                                      ])),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      RichText(
                                          text: TextSpan(children: [
                                        const TextSpan(
                                            text: "Milk type : ",
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        TextSpan(
                                            text: shellBuyBody[index]
                                                    .subProducttypeName ??
                                                '',
                                            style: const TextStyle(
                                                color: Colors.black)),
                                      ])),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      RichText(
                                          text: TextSpan(children: [
                                        const TextSpan(
                                            text: "Quantity : ",
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        TextSpan(
                                            text: shellBuyBody[index]
                                                    .avaiablequanitity ??
                                                '',
                                            style: const TextStyle(
                                                color: Colors.black)),
                                      ])),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      RichText(
                                          text: const TextSpan(children: [
                                        TextSpan(
                                            text: "Location : ",
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        TextSpan(
                                            text: "Thanjavur",
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ])),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      RichText(
                                          text: TextSpan(children: [
                                        const TextSpan(
                                            text: "Post Type : ",
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        TextSpan(
                                            text:
                                                shellBuyBody[index].postType ??
                                                    '',
                                            style: const TextStyle(
                                                color: Colors.black)),
                                      ])),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(right: 50),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            color: const Color.fromARGB(
                                                255, 20, 80, 129),
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
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          padding: const EdgeInsets.all(8),
                                          alignment: Alignment.center,
                                          child: InkWell(
                                              onTap: () {
                                                // Navigator.pop(context);
                                                var route = MaterialPageRoute(
                                                    builder: (context) =>
                                                        SellListDetail(
                                                          shellBuyBody:
                                                              shellBuyBody[
                                                                  index],
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
                                    ],
                                  ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, index) {
                      return const Divider();
                    },
                    itemCount: shellBuyBody.length),
              ),
              // Container(
              //   height: 50,
              //   width: double.infinity,
              //   color: Color.fromARGB(255, 24, 97, 156),
              //   child: TabBar(
              //     controller: controller,overlayColor: const MaterialStatePropertyAll(Color.fromARGB(255, 24, 97, 156),),
              //    // indicatorWeight: 2.0,
              //    indicatorSize: TabBarIndicatorSize.label,
              //     labelStyle: const TextStyle(fontSize: 16),
              //     indicatorColor: Colors.white,
              //     padding: const EdgeInsets.all(0.0),
              //     tabs: const [Text("Buy List"), Text("Sell List")],
              //   ),
              // ),
              // Expanded(
              //   child: TabBarView(
              //     //viewportFraction: 2.0,
              //     physics: const NeverScrollableScrollPhysics(),
              //     controller: controller,
              //     children: [buyList(buyBody), sellList(shellBody)],
              //   ),
              // ),
            ],
          );
        }),
      ),
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       heroTag: "btn1",
      //       backgroundColor: const Color.fromARGB(255, 24, 97, 156),
      //       onPressed: () {
      //         var route =
      //             MaterialPageRoute(builder: (context) => const SellPostPage());
      //         Navigator.push(context, route);
      //       },
      //       child: const Icon(
      //         Icons.sell,
      //       ),
      //     ),
      //     const SizedBox(
      //       height: 10,
      //     ),
      //     FloatingActionButton(
      //       heroTag: "btn2",
      //       backgroundColor: const Color.fromARGB(255, 24, 97, 156),
      //       onPressed: () {
      //         var route =
      //             MaterialPageRoute(builder: (context) => const BuyPostPage());
      //         Navigator.push(context, route);
      //       },
      //       child: const Icon(
      //         Icons.find_in_page,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  // Widget sellList(List<ShellBuyBody> sell) {
  //   return ListView.separated(
  //       itemBuilder: (_, index) {
  //         return Card(
  //           color: Colors.white,
  //           margin: const EdgeInsets.all(2.0),
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //             margin: const EdgeInsets.all(10.0),
  //             child: Column(
  //               children: [
  //                 Row(
  //                   children: [
  //                    sell[index].prductImage!=null? CircleAvatar(
  //                         // width: 50,
  //                         // height: 50,
  //                         /*decoration: BoxDecoration(
  //                                         color: Colors.red,
  //                                         borderRadius: BorderRadius.circular(50.0)),*/
  //                         backgroundImage:NetworkImage(sell[index].prductImage!)): SizedBox(
  //                           width: 50,
  //                         height: 50,child: Image.asset("assests/taknerlogo.jpg"),
  //                         ),
  //                     const SizedBox(width: 10),
  //                     Expanded(
  //                         child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       mainAxisSize: MainAxisSize.max,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         RichText(
  //                             text: TextSpan(children: [
  //                           const TextSpan(
  //                               text: "Product Name : ",
  //                               style: TextStyle(color: Colors.grey)),
  //                           TextSpan(
  //                               text: sell[index].subProducttypeName ?? '',
  //                               style: const TextStyle(color: Colors.black)),
  //                         ])),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         RichText(
  //                             text: TextSpan(children: [
  //                           const TextSpan(
  //                               text: "Available Qty : ",
  //                               style: TextStyle(color: Colors.grey)),
  //                           TextSpan(
  //                               text: sell[index].avaiablequanitity ?? '',
  //                               style: const TextStyle(color: Colors.black)),
  //                         ])),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         RichText(
  //                             text: TextSpan(children: [
  //                           const TextSpan(
  //                               text: "Milk Type : ",
  //                               style: TextStyle(color: Colors.grey)),
  //                           TextSpan(
  //                               text: sell[index].postType ?? '',
  //                               style: const TextStyle(color: Colors.black)),
  //                         ])),
  //                       ],
  //                     ))
  //                   ],
  //                 ),
  //                 Container(
  //                     width: 400,
  //                     padding: const EdgeInsets.only(left: 10),
  //                     child: ElevatedButton(
  //                         style: const ButtonStyle(
  //                             backgroundColor: MaterialStatePropertyAll(
  //                           Color.fromARGB(255, 24, 97, 156),
  //                         )),
  //                         onPressed: () {
  //                           popupWidget(
  //                             nameController: name,
  //                             contactController: contact,
  //                             onPressed: () {
  //                               Navigator.pop(context);
  //                               var route = MaterialPageRoute(
  //                                   builder: (context) => SellListDetail(
  //                                         shellBuyBody: shellBody[index],
  //                                       ));
  //                               Navigator.of(context).push(route);
  //                             },
  //                           );
  //                         },
  //                         child: const Text('View More')))
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //       separatorBuilder: (_, index) {
  //         return const Divider();
  //       },
  //       itemCount: sell.length);
  // }

  // Widget buyList(List<ShellBuyBody> buy) {
  //   return ListView.separated(
  //       itemBuilder: (_, index) {
  //         return Card(
  //           color: Colors.white,
  //           margin: const EdgeInsets.all(2.0),
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 2.0),
  //             margin: const EdgeInsets.all(8.0),
  //             child: Column(
  //               children: [
  //                 Row(
  //                   children: [
  //                     buy[index].prductImage!=null? CircleAvatar(
  //                         // width: 50,
  //                         // height: 50,
  //                         /*decoration: BoxDecoration(
  //                                         color: Colors.red,
  //                                         borderRadius: BorderRadius.circular(50.0)),*/
  //                         backgroundImage:NetworkImage(buy[index].prductImage!)): SizedBox(
  //                           width: 50,
  //                         height: 50,child: Image.asset("assests/taknerlogo.jpg"),
  //                         ),
  //                     const SizedBox(width: 10),
  //                     Expanded(
  //                         child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       mainAxisSize: MainAxisSize.max,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         RichText(
  //                             text: TextSpan(children: [
  //                           const TextSpan(
  //                               text: "Product Name : ",
  //                               style: TextStyle(color: Colors.grey)),
  //                           TextSpan(
  //                               text: buy[index].subProducttypeName ?? '',
  //                               style: const TextStyle(color: Colors.black)),
  //                         ])),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         RichText(
  //                             text: TextSpan(children: [
  //                           const TextSpan(
  //                               text: "Required Qty : ",
  //                               style: TextStyle(color: Colors.grey)),
  //                           TextSpan(
  //                               text: buy[index].avaiablequanitity ?? '',
  //                               style: const TextStyle(color: Colors.black)),
  //                         ])),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         RichText(
  //                             text: TextSpan(children: [
  //                           const TextSpan(
  //                               text: "Milk Type : ",
  //                               style: TextStyle(color: Colors.grey)),
  //                           TextSpan(
  //                               text: buy[index].postType ?? '',
  //                               style: const TextStyle(color: Colors.black)),
  //                         ])),
  //                       ],
  //                     )),
  //                   ],
  //                 ),
  //                 Container(
  //                     width: 400,
  //                     padding: const EdgeInsets.only(left: 10),
  //                     child: ElevatedButton(
  //                         style: const ButtonStyle(
  //                             backgroundColor: MaterialStatePropertyAll(
  //                           Color.fromARGB(255, 24, 97, 156),
  //                         )),
  //                         onPressed: () {
  //                           popupWidget(
  //                             nameController: name,
  //                             contactController: contact,
  //                             onPressed: () {
  //                               Navigator.pop(context);
  //                               var route = MaterialPageRoute(
  //                                   builder: (context) => BuyListDetail(
  //                                         shellBuyBody: buy[index],
  //                                       ));
  //                               Navigator.of(context).push(route);
  //                             },
  //                           );
  //                         },
  //                         child: const Text('View More',
  //                             style: TextStyle(color: Colors.white))))
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //       separatorBuilder: (_, index) {
  //         return const Divider();
  //       },
  //       itemCount: buyBody.length);
  // }

 
}


// ListTile(
//                   leading: SizedBox(
//                       width: 80,
//                       height: 100,
//                       /*decoration: BoxDecoration(
//                                           color: Colors.red,
//                                           borderRadius: BorderRadius.circular(50.0)),*/
//                       child: Image.asset('assests/taknerlogo.jpg')),
//                   // title: Text(" ${buy[index].productName ?? ""}"),
//                   title: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                             " ${buy[index].firstName ?? "Thivakar"} ${buy[index].lastName ?? ""}"),
//                         Text(" ${buy[index].subProducttypeName ?? ""}"),
//                         Row(
//                           children: [
//                             Text(
//                                 " ${buy[index].avaiablequanitity ?? ""} litres |"),
//                             Text(" ${buy[index].price ?? ""} rupees"),
//                           ],
//                         ),
//                       ]),
//                   trailing: ActionChip(
//                       onPressed: () {},
//                       backgroundColor: const Color.fromARGB(255, 76, 107, 134),
//                       labelPadding:
//                           const EdgeInsets.symmetric(horizontal: 10.0),
//                       label: Text('${buy[index].postType}',
//                           style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400))),
//                 )