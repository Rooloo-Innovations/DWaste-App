import 'package:dwaste/widgets/DAppbar.dart';
import 'package:flutter/material.dart';

import '../widgets/CustomButton.dart';
class PaymentSuccessfulScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
            appBar: DAppbar(),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("cart.png"),
                      Padding(
                          padding: EdgeInsets.only(top: 19),
                          child: Text("Congratulations!",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0x000000FF),
                                  fontFamily: "Inter",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700))),
                      Container(
                          width: 296,
                          margin: EdgeInsets.only(left: 15, top: 16, right: 15),
                          child: Text(
                              "You have successfully placed the order. Your order will be shipped in 2-3 business days.",
                              maxLines: null,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0x919191),
                                  fontFamily: "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400))),
                      CustomButton(
                          height: 56,
                          text: "Go to home",
                          margin: EdgeInsets.only(top: 17))
                    ]))));
  }

  onTapArrowleft(BuildContext context) {
    Navigator.pop(context);
  }
}
