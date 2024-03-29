import 'package:dwaste/models/app_colors.dart';
import 'package:dwaste/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.product,
  });

  final String image;
  final String name;
  final int price;
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  final product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductScreen(product: product),
          ));
        },
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6),
          ], color: AppColors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 100,
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Image(
                              image:
                                  AssetImage('assets/images/placeholder.png'));
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  capitalize(name),
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  softWrap: true,
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/icons/DIcon.svg',
                      width: 14,
                      height: 14,
                      colorFilter: const ColorFilter.mode(
                          AppColors.green, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      price.toString(),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.green),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
