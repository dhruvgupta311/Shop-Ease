import 'package:ShopSphere/features/account/services/account_services.dart';
import 'package:ShopSphere/features/account/widgets/account_button.dart';
import 'package:ShopSphere/features/account/widgets/orders.dart';
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0.0),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      // color: Color.fromARGB(255, 18, 13, 13),
        width: double.infinity,
        child: Column(
          
          children: [
            const SizedBox(height: 10),
            AccountButton(
              text: 'Your Orders',
              onTap: () {},
            ),
            // const SizedBox(height: 10),
            Divider(height: 10, ),
            AccountButton(
              text: 'Turn Seller',
              onTap: () {},
            ),
            Divider(height: 10, ),
            // const SizedBox(height: 10),
            AccountButton(
              text: 'Log Out',
              onTap: () => AccountServices().logOut(context),
            ),
                 Divider(height: 10, ),
            // const SizedBox(height: 10),
            AccountButton(
              text: 'Your Wish List',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
