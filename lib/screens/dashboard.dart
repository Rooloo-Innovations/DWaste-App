import 'package:dwaste/components/dashboard_item.dart';
import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/gql_client.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double _consumedData = 0 / 10;
  int progress = 0;
  String name = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUser();
    fetchProgress();
  }

  void fetchUser() async {
    final GraphQLClient client = await getClient();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('access_token', '');
    String? token = prefs.getString('access_token');

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);

    print(decodedToken);

    final QueryOptions options = QueryOptions(document: gql(r'''
query User($userId: String!) {
  user(userID: $userId) {
    success
    message
    users {
      fullName
    }
  }
}
    '''), variables: {"userId": decodedToken['userID']});

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw result.exception.toString();
    } else {
      setState(() {
        name = result.data!['user']['users'][0]['fullName'];
      });
    }
  }

  void fetchProgress() async {
    final GraphQLClient client = await getClient();

    final QueryOptions options = QueryOptions(
      document: gql(r'''
query FetchRewards {
  fetchRewards {
    success
    message
    rewards {
      dailyRewards
    }
  }
}
    '''),
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw result.exception.toString();
    } else {
      final int dailyRewards =
          result.data!['fetchRewards']['rewards']['dailyRewards'];

      print(result.data);

      setState(() {
        progress = (dailyRewards / 50).round();
        _consumedData = progress / 10;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/dashboard_vector.svg',
            width: 512,
            height: 512,
            colorFilter:
                const ColorFilter.mode(Color(0x55ffffff), BlendMode.srcIn),
          ),
          Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello $name",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                        ),
                        const Text("Let's recycle",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                                fontSize: 26)),
                      ],
                    ),
                    SizedBox(
                      height: 64,
                      width: 64,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.backgroundColor,
                          ),
                          child: Image.asset(
                            "assets/images/avatar.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        "Progress",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 12),
                          ],
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Plastic Recycled:",
                                  style: TextStyle(
                                    color: AppColors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "$progress/10 items",
                                  style: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                SizedBox(
                                  width: 180.0,
                                  height: 12,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: LinearProgressIndicator(
                                      value: _consumedData,
                                      color: AppColors.green,
                                      backgroundColor:
                                          AppColors.black.withOpacity(0.1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              "assets/images/progress_ball.png",
                              fit: BoxFit.contain,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const Text(
                        "Item's to scan",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // DashboardItem(),
                      SizedBox(
                        height: 280,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            DashboardItem(),
                            DashboardItem(),
                            DashboardItem(),
                            DashboardItem(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
