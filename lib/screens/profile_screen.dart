import 'package:dwaste/components/balance_container.dart';
import 'package:dwaste/components/reward_material.dart';
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
  String publicKey = "";
  List rewardList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
    fetchRewards();
  }

  void fetchUserData() async {
    final GraphQLClient client = await getClient();

    final QueryOptions options = QueryOptions(
      document: gql(r'''
query UserDetails {
  userDetails {
    success
    message
    users {
      denrTokens
      publicKey
    }
  }
}
    '''),
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw result.exception.toString();
    } else {
      setState(() {
        denrBalance = result.data!['userDetails']['users'][0]['denrTokens'];
        publicKey = result.data!['userDetails']['users'][0]['publicKey'];
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
            publicKey: publicKey,
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
                      rewardList[index]['scannedOn'])),
            ),
          ),
          // const SizedBox(
          //   height: 24,
          // ),
          // const Text(
          //   "Transactions",
          //   style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.w700,
          //       color: AppColors.black),
          // ),
          // Column(
          //   children: [],
          // ),
          // const TransactionCard(),
          // const TransactionCard(),
          // const TransactionCard(),
        ],
      ),
    );
  }
}
