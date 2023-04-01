import 'package:dwaste/components/balance_container.dart';
import 'package:dwaste/components/reward_material.dart';
import 'package:dwaste/components/transaction_material.dart';
import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/gql_client.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int denrBalance = 0;
  List rewardList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBalance();
    fetchRewards();
  }

  void fetchBalance() async {
    final GraphQLClient client = await getClient();

    final QueryOptions options = QueryOptions(
      document: gql(r'''
query FetchRewards {
  fetchRewards {
    success
    message
    rewards {
      totalRewards
    }
  }
}
    '''),
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw result.exception.toString();
    } else {
      print(result.data);
      setState(() {
        denrBalance = result.data!['fetchRewards']['rewards']['totalRewards'];
      });
    }
  }

  void fetchRewards() async {
    final GraphQLClient client = await getClient();

    final QueryOptions options = QueryOptions(
      document: gql(r'''
query AllScannedByUserID {
  allScannedByUserID {
    scanned {
      userID
      productType
      pointsEarned
      scannedOn
    }
  }
}
    '''),
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw result.exception.toString();
    } else {
      print(result.data);
      setState(() {
        rewardList = result.data!['allScannedByUserID']['scanned'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        children: [
          const SizedBox(
            height: 120,
          ),
          const Text(
            "DENR Balance",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.black),
          ),
          const SizedBox(
            height: 18,
          ),
          BalanceContainer(
            denrBalance: denrBalance,
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            "Rewards",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.black),
          ),
          Column(
            children: List<Widget>.generate(
              rewardList.length,
              (index) => RewardMaterial(
                productType: rewardList[index]['productType'],
                pointsEarned: rewardList[index]['pointsEarned'],
                scannedOn: DateTime.fromMillisecondsSinceEpoch(
                    rewardList[index]['scannedOn']),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            "Transactions",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.black),
          ),
          Column(
            children: [],
          ),
          const TransactionCard(),
          const TransactionCard(),
          const TransactionCard(),
        ],
      ),
    );
  }
}
