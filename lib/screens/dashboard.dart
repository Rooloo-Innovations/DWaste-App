import 'package:dwaste/components/dashboard_item.dart';
import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final double _consumedData = 8 / 10;
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
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello Maria",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text("Let's recycle",
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
                                const Text(
                                  "4/10 items",
                                  style: TextStyle(
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
                            SizedBox(
                              height: 128,
                              width: 128,
                              child: Image.asset(
                                "assets/images/progress_ball.png",
                                fit: BoxFit.cover,
                              ),
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
