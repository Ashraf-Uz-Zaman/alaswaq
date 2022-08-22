import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/material.dart';

class AboutAlaswaq extends StatefulWidget {
  @override
  _AboutAlaswaqState createState() => _AboutAlaswaqState();
}

class _AboutAlaswaqState extends State<AboutAlaswaq> {
  String text1 ='''ARAK National Markets was established in the year 1987. This company has a strong presence in the retail business sector in Ras Al Khaimah with it super Markets. At present 9 Hypermarkets operate in different locations across Ras Al Khaimah in fully owned premises.
 

Since its beginning with one rather small outlet the company has grown to its present size of 8 large outlets. The management is committed to offering quality and shopping comfort to its customers. In the selection and variety of fresh foods, RAK National Markets, Al Aswaq for short, has become a name synonymous with excellence. True to its mission of absolute customer satisfaction, the company provides the Fresh fruits, Vegetables’, quality meats and bakery products every day.

The management systems rely heavily on information technology. This helps in management of the inventory to ensure that the supermarkets are well stocked and the products are well within shelf life. There is a continuous monitoring to remove products from display when approach expiry date. Elaborate focus is given to fresh foods such as Vegetables’, Fruits and meat. There are special arrangements for the procurement and processing of these products to ensure that our customers get the best value for money.

Nine Hypermarkets in convenient location across Ras Al Khaimah.The retail operations are supported by a well-organized inventory procurement and warehousing system. The entire operations are driven by an IT infrastructure.''';

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
          'About Alaswaq',
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
            maxLines: 200,
          ),
        ),
      ),
    );
  }
}
