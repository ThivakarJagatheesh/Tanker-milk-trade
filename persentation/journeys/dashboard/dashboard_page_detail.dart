import 'package:dairy_products/common/widgets/text_style.dart';
import 'package:dairy_products/persentation/journeys/buy_list/buy_lis.dart';
import 'package:dairy_products/persentation/journeys/buy_post/buy.dart';
import 'package:dairy_products/persentation/journeys/buy_sell_List/buy_sell_list.dart';
import 'package:dairy_products/persentation/journeys/product_enquiry/product_enquiry.dart';
import 'package:dairy_products/persentation/journeys/profile_setting/profile_info.dart';
import 'package:dairy_products/persentation/journeys/sell_list/sell_list.dart';
import 'package:dairy_products/persentation/journeys/sell_post/sell.dart';
import 'package:dairy_products/persentation/journeys/trade_info/trade_info.dart';
import 'package:flutter/material.dart';

class DashboardPageDetail extends StatefulWidget {
  const DashboardPageDetail({super.key});

  @override
  State<DashboardPageDetail> createState() => _DashboardPageDetailState();
}

class _DashboardPageDetailState extends State<DashboardPageDetail> {
    List<String> name = [
    "Profile setting",
    "Trade setting",
    "Sell Now",
    "Buy Now",
    "Product enquiry",
    "Reports",
    "Invite friends",
    "Contact Admin"
  ];
  List<String> image = [
    "assests/icons_profile.png",
    "assests/icons_businessprofile.png",
    "assests/icons_sellnow.png",
    "assests/icons_buynow.png",
    "assests/icons_enquiry.png",
    "assests/icons_reports.png",
    "assests/icons_invitefriends.png",
    "assests/setting.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
                padding: const EdgeInsets.all(20.0),
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemBuilder: (_, i) {
                  return InkWell(
                    onTap: () {
                      if (name[i] == "Trade setting") {
                        var route = MaterialPageRoute(
                            builder: (context) => const TradeInfoPage());
                        Navigator.push(context, route);
                      } else if (name[i] == "Profile setting") {
                        var route = MaterialPageRoute(
                            builder: (context) => const ProfileInfo());
                        Navigator.push(context, route);
                      } else if (name[i] == "Buy Now") {
                        var route = MaterialPageRoute(
                            builder: (context) => const BuyListWidget());
                        Navigator.push(context, route);
                      } else if (name[i] == "Sell Now") {
                        var route = MaterialPageRoute(
                            builder: (context) => const SellListWidget());
                        Navigator.push(context, route);
                      } else if (name[i] == "Product enquiry") {
                        var route = MaterialPageRoute(
                            builder: (context) => const ProductEnquiryWidget());
                        Navigator.push(context, route);
                      }
                    },
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30.0, bottom: 10),
                              child: Center(
                                child: SizedBox(
                                    width: 100,
                                    height: 80,
                                    /*decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(50.0)),*/
                                    child: Image.asset(image[i])),
                              ),
                            ),
                            // const Spacer(),
                            Text(name[i],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: CommonStyles(context).style()),
                          ],
                        ),
                      ),
                    ),
                  );
                });
  }
}