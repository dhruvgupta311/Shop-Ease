import 'package:ShopSphere/common/widgets/loader.dart';
// import 'package:ShopSphere/constants/global_variables.dart';
// import 'package:ShopSphere/features copy/account/services/account_services.dart';
// import 'package:ShopSphere/features copy/account/widgets/single_product.dart';
// import 'package:ShopSphere/features copy/order_details/screens/order_details.dart';
import 'package:ShopSphere/models/order.dart';
import 'package:flutter/material.dart';

import '../../order_details/screens/order_details.dart';
import '../services/account_services.dart';
import 'single_product.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }
  // List order = [
  //   "https://images.unsplash.com/photo-1682687220777-2c60708d6889?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8",
  //   "https://images.unsplash.com/photo-1682687220777-2c60708d6889?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8",
  //   "https://images.unsplash.com/photo-1536782376847-5c9d14d97cc0?q=80&w=1776&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  //   "https://unsplash.com/photos/body-of-water-during-sunset-Xbf_4e7YDII",
  // ];

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.only(
                  //     right: 15,
                  //   ),
                  //   child: Text(
                  //     'See all',
                  //     style: TextStyle(
                  //       color: GlobalVariables.selectedNavBarColor,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              // display orders
              // if(orders!.isEmpty) Center(child: Text("No Orders....Order Something"),),
              Container(
                height: 170,
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                  right: 0,
                ),
                child: (orders!.isEmpty)?Center(child: Text("No Orders....Order Something", style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.bold),),):ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          OrderDetailScreen.routeName,
                          arguments: orders![index],
                        );
                      },
                      child: SingleProduct(
                        // image: orders[index],
                        image: orders![index].products[0].images[0],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}

// class AccountServices {
//   fetchMyOrders({required BuildContext context}) {}

//   logOut(BuildContext context) {}
// }
