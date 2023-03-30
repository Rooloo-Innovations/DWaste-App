import 'package:flutter/material.dart';

import '../models/app_colors.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Your Rewards',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1), blurRadius: 12),
                    ],
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/images/trophy.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Congratulations',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColors.green,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 16.0),
                            SizedBox(
                              width: 160.0,
                              child: Text(
                                'Good job at keeping your city clean. Your contribution matters.',
                                style: TextStyle(fontSize: 12.0),
                                softWrap: true,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28.0),
                const Text(
                  'DENR Earned',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1), blurRadius: 12),
                    ],
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '50 DENR',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColors.green,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 16.0),
                            SizedBox(
                              width: 160.0,
                              child: Text(
                                'Yay! you just earned DENR, you can use DENR on our shop or withdraw.',
                                style: TextStyle(fontSize: 12.0),
                                softWrap: true,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/images/coin.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(32.0),
            decoration: const BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Tips on recycling',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  '#Plastic',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Check local guidelines, clean and sort plastic by type, avoid non-recyclable plastics such as Styrofoam or plastic bags, and dispose of properly.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(40.0),
                      ),
                    ),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(20)),
                    backgroundColor: MaterialStateProperty.all(AppColors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: AppColors.green),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
