import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/withdraw_screen.dart';

class BalanceContainer extends StatelessWidget {
  const BalanceContainer({super.key, this.denrBalance});

  final denrBalance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/balance_background.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/bank_logo.svg',
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    "Dwaste",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    "Total Balance",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white),
                  ),
                  Text(
                    "DENR $denrBalance",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    width: 160,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const WithdrawScreen(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            AppColors.white.withOpacity(0.8)),
                        foregroundColor:
                            MaterialStateProperty.all(AppColors.green),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      child: const Text("Withdraw"),
                    ),
                  )
                ],
              ),
              Expanded(child: Image.asset('assets/images/balance_earth.png')),
            ],
          ),
        ),
      ),
    );
  }
}
