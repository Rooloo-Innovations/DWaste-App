import 'package:dwaste/components/balance_container.dart';
import 'package:dwaste/components/reward_material.dart';
import 'package:dwaste/components/transaction_material.dart';
import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        children: const [
          SizedBox(
            height: 120,
          ),
          Text(
            "DENR Balance",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.black),
          ),
          SizedBox(
            height: 18,
          ),
          BalanceContainer(),
          SizedBox(
            height: 24,
          ),
          Text(
            "Rewards",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.black),
          ),
          RewardMaterial(),
          RewardMaterial(),
          RewardMaterial(),
          RewardMaterial(),
          RewardMaterial(),
          SizedBox(
            height: 24,
          ),
          Text(
            "Transactions",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.black),
          ),
          TransactionMaterial(),
          TransactionMaterial(),
          TransactionMaterial(),
        ],
      ),
    );
  }
}
