import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _headerStyle = const TextStyle(
      color: AppColors.black, fontSize: 15, fontWeight: FontWeight.w600);
  final _contentStyleHeader = const TextStyle(
      color: AppColors.black, fontSize: 14, fontWeight: FontWeight.w700);
  final _contentStyle = const TextStyle(
      color: AppColors.black, fontSize: 14, fontWeight: FontWeight.normal);
  final _loremIpsum =
      '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        child: ListView(
          children: [
            SizedBox(
              height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/headphone.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'The Everyday Headphones',
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/icons/DIcon.svg',
                  width: 20,
                  height: 20,
                  colorFilter:
                      const ColorFilter.mode(AppColors.green, BlendMode.srcIn),
                ),
                const SizedBox(
                  width: 3,
                ),
                const Text(
                  "10",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.green),
                ),
                const SizedBox(
                  width: 20,
                ),
                SvgPicture.asset(
                  'assets/images/icons/DIcon.svg',
                  width: 18,
                  height: 18,
                  colorFilter: const ColorFilter.mode(
                      Color(0xffc2c2c2), BlendMode.srcIn),
                ),
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  "20",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffc2c2c2),
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(
              child: Divider(
                color: AppColors.grey,
              ),
            ),
            Accordion(
              contentBorderRadius: 0,
              headerBorderRadius: 0,
              rightIcon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.black,
                size: 20,
              ),
              flipRightIconIfOpen: true,
              maxOpenSections: 1,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 0),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: [
                AccordionSection(
                  isOpen: true,
                  headerBackgroundColor: Colors.white,
                  headerBackgroundColorOpened: Colors.white,
                  contentBorderWidth: 0,
                  header: Text('product details', style: _headerStyle),
                  content: Text(_loremIpsum, style: _contentStyle),
                  contentHorizontalPadding: 0,
                  // onOpenSection: () => print('onOpenSection ...'),
                  // onCloseSection: () => print('onCloseSection ...'),
                ),
              ],
            ),
            AppTextButton(
              text: 'Buy Now',
              onPressed: () => {},
            )
          ],
        ),
      ),
    );
  }
}

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(40.0),
          ),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
        backgroundColor: MaterialStateProperty.all(AppColors.green),
      ),
      child: Text(
        text,
        style: TextStyle(color: AppColors.white),
      ),
    );
  }
}
