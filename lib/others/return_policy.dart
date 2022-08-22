import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/material.dart';

class ReturnPolicy extends StatefulWidget {
  @override
  _ReturnPolicyState createState() => _ReturnPolicyState();
}

class _ReturnPolicyState extends State<ReturnPolicy> {
  String text1 ='''If you wish to return item/s, please give us a call at at +971 600 500202 or send us email at customerservice@aswaqrak.ae..

For perishable items such as fruits, vegetables, frozen, and fresh products, request for return can be requested on the same day within 3 hours from the delivery time.

Items that are non-perishable must be returned with its complete box or packaging and all accessories. Return request shall be requested up to 7 days from the delivery time for non-perishable items.

Refunds will be made in the same manner in which the purchase of the item was made; items purchased in cash will be refunded by cash while items purchased by credit/debit card will be refunded back in credit/debit card.

Our staff will be designated to collect back the item and refund will be processed. Please allow for up to 45 days for the refund transfer to be completed.''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        // hides leading widget
//        flexibleSpace: Container(),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
            size: 30,
          ),
        ),
        title: Text(
          'Refund And Return Policy',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(10,20,10,20),
          child: Text(
            text1,
            maxLines: 2500,
          ),
        ),
      ),
    );
  }
}
