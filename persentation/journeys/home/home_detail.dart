import 'package:dairy_products/common/widgets/local_storage/shared_storage.dart';
import 'package:dairy_products/common/widgets/text_style.dart';
import 'package:dairy_products/data/api_config/api_config.dart';
import 'package:dairy_products/di/get_it.dart';
import 'package:dairy_products/persentation/bloc/dashboard/dashboard_cubit.dart';
import 'package:dairy_products/persentation/bloc/dashboard/dashboard_state.dart';
import 'package:dairy_products/persentation/journeys/authentication/login.dart';
import 'package:dairy_products/persentation/journeys/buy_post/buy.dart';
import 'package:dairy_products/persentation/journeys/buy_sell_List/buy_sell_list.dart';
import 'package:dairy_products/persentation/journeys/buy_sell_List/buy_sell_list_detail.dart';
import 'package:dairy_products/persentation/journeys/dashboard/dashboard_page_detail.dart';
import 'package:dairy_products/persentation/journeys/product_enquiry/product_enquiry.dart';
import 'package:dairy_products/persentation/journeys/profile_setting/profile_info_detail.dart';
import 'package:dairy_products/persentation/journeys/sell_post/sell.dart';
import 'package:dairy_products/persentation/journeys/trade_info/trade_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageDetail extends StatefulWidget {
  const HomePageDetail({super.key});

  @override
  State<HomePageDetail> createState() => _HomePageDetailState();
}

class _HomePageDetailState extends State<HomePageDetail> {
  int selectedIndex = 0;
  late DashboardBloc dashboardBloc;
  String appBarLabel = "Tanker Milk";
  @override
  void initState() {
    super.initState();
    dashboardBloc = getItInstance<DashboardBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 97, 156),
        centerTitle: true,
        title: Text(
          appBarLabel,
          style: CommonStyles(context).appBarStyle(),
        ),
      ),
      drawer: Drawer(
          child: DrawerHeader(
              padding: EdgeInsets.zero,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Color.fromARGB(255, 24, 97, 156),
                          ))
                    ],
                    leading: CircleAvatar(
                      radius: 20,
                      child: Image.asset("assests/taknerlogo.jpg"),
                    ),
                    title: const Text(
                      "Tanker Milk",
                      style: TextStyle(
                          color: Color.fromARGB(255, 24, 97, 156),
                          fontSize: 16),
                    ),
                    leadingWidth: 50,
                  ),
                  ListTile(
                    title: const Text("Profile setting"),
                    onTap: () {
                      var route = MaterialPageRoute(
                          builder: (context) => const ProfileInfoDetail());
                      Navigator.push(context, route);
                    },
                  ),
                  ListTile(
                    title: const Text("Trade setting"),
                    onTap: () {
                      var route = MaterialPageRoute(
                          builder: (context) => const TradeInfoPage());
                      Navigator.push(context, route);
                    },
                  ),
                  ListTile(
                    title: const Text("Sell Now"),
                    onTap: () {
                      var route = MaterialPageRoute(
                          builder: (context) => const SellPostPage());
                      Navigator.push(context, route);
                    },
                  ),
                  ListTile(
                    title: const Text("Buy Now"),
                    onTap: () {
                      var route = MaterialPageRoute(
                          builder: (context) => const BuyPostPage());
                      Navigator.push(context, route);
                    },
                  ),
                  ListTile(
                    title: const Text("Product enquiry"),
                    onTap: () {
                      var route = MaterialPageRoute(
                          builder: (context) => const ProductEnquiryWidget());
                      Navigator.push(context, route);
                    },
                  ),
                   ListTile(
                    title:const Text("Reports"),
                  onTap: () {
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                "comming soon....",
                style: CommonStyles(context).style(color: Colors.white),
              )));
                  },
                  ),
                   ListTile(
                    title: const Text("Invite friends"),
                       onTap: () {
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                "comming soon....",
                style: CommonStyles(context).style(color: Colors.white),
              )));
                  },
                  ),
                   ListTile(
                    title: const Text("Contact Admin"),
                       onTap: () {
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                "comming soon....",
                style: CommonStyles(context).style(color: Colors.white),
              )));
                  },
                  ),
                  ListTile(
                    title: const Text("Exit"),
                    onTap: () async {
                      await SharedStorage.remove(ApiConfig.userId);
                      var route = MaterialPageRoute(
                          builder: (context) => const LoginDemo());
                      // ignore: use_build_context_synchronously
                      Navigator.pushAndRemoveUntil(
                          context, route, (r) => false);
                    },
                  ),
                ],
              ))),
      body: BlocProvider.value(
          value: dashboardBloc,
          child: BlocConsumer<DashboardBloc, DashboardState>(
              listener: (context, state) {
            if (state is SettingState) {
              appBarLabel = "Setting";
            } else if (state is SupportState) {
              appBarLabel = "Support";
            } else if (state is ServicesState) {
              appBarLabel = "Dashboard";
            } else {
              appBarLabel = "Tanker Milk";
            }
          }, builder: (context, state) {
            if (state is SettingState) {
              return const Center(child: Text("Comming soon....."));
            } else if (state is SupportState) {
              return const Center(child: Text("Comming soon....."));
            } else if (state is ServicesState) {
              return const DashboardPageDetail();
            } else {
              return const BuySellListDetail();
            }
          })),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              dashboardBloc.selectedItems(value);
              selectedIndex = value;
            });
          },
          backgroundColor: const Color.fromARGB(255, 24, 97, 156),
          selectedItemColor: const Color.fromARGB(255, 24, 97, 156),
          unselectedItemColor: Colors.black,
          useLegacyColorScheme: false,
          currentIndex: selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sell_rounded),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.share),
              label: "Support",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Setting",
            )
          ]),
    );
  }
}
