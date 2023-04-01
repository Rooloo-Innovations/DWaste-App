import 'package:dotted_line/dotted_line.dart';
import 'package:dwaste/components/app_bar.dart';
import 'package:dwaste/components/app_textfield.dart';
import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/gql_client.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen(
      {super.key,
      this.productId,
      this.productName,
      this.productPrice,
      this.productImage});

  final productId;
  final productName;
  final productPrice;
  final productImage;

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _currentStep = 0;

  String errorMessage = "";

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _subtotalController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // createOrder();
  }

  Future<bool> createOrder() async {
    final GraphQLClient client = await getClient();

    final MutationOptions options = MutationOptions(document: gql(r'''
mutation CreateNewOrder($productId: String!, $amount: Int!, $quantity: Int!, $address: AddOrderAddress!) {
  createNewOrder(productID: $productId, amount: $amount, quantity: $quantity, address: $address) {
    success
    message
    orders {
      id
      userID
      productID
      amount
      quantity
      address {
        fullName
        phoneNumber
        street
        apartment
        city
        state
        pinCode
      }
      paymentStatus
      deliveryStatus
      dispatchStatus
      orderPlacedOn
    }
  }
}
    '''), variables: {
      "productId": widget.productId,
      "amount": widget.productPrice,
      "quantity": 1,
      "address": {
        "fullName": _fullNameController.text,
        "phoneNumber": _phoneNumberController.text,
        "street": _streetAddressController.text,
        "apartment": _apartmentController.text,
        "state": _stateController.text,
        "city": _cityController.text,
        "pinCode": _postalCodeController.text
      }
    });

    final QueryResult result = await client.mutate(options);

    print("Im Here");

    if (result.hasException) {
      throw result.exception.toString();
    } else {
      print(result.data);
      // setState(() {
      bool orderStatus = result.data!['createNewOrder']['success'];
      bool orderResponse = result.data!['createNewOrder']['message'];

      if (!orderStatus) {}

      return orderStatus;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProgressTimeline(),
              const SizedBox(height: 32),
              _buildStepContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressTimeline() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _currentStep = 0;
            });
          },
          child: _buildStepCircle('1', 'Address', _currentStep >= 0),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: _currentStep > 0 ? AppColors.green : AppColors.grey,
            ),
            height: 1.5,
            margin: const EdgeInsets.only(bottom: 16),
          ),
        ),
        GestureDetector(
          onTap: () {
            // setState(() {
            //   _currentStep = 1;
            // });
          },
          child: _buildStepCircle('2', 'Order Summary', _currentStep >= 1),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: _currentStep > 1 ? AppColors.green : AppColors.grey,
            ),
            height: 1.5,
            margin: const EdgeInsets.only(bottom: 16),
          ),
        ),
        GestureDetector(
          onTap: () {
            // setState(() {
            //   _currentStep = 2;
            // });
          },
          child: _buildStepCircle('3', 'Completion', _currentStep >= 2),
        ),
      ],
    );
  }

  Widget _buildStepCircle(String number, String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                isActive ? AppColors.green.withOpacity(0.2) : AppColors.white,
            border: Border.all(
              color: AppColors.green,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: AppColors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildAddressStep();
      case 1:
        return _buildOrderSummaryStep();
      case 2:
        return _buildCompletionStep();
      default:
        return Container();
    }
  }

  Widget _buildAddressStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "* All fields are mandatory",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 12,
            color: AppColors.black.withOpacity(0.7),
          ),
        ),
        AppTextFields(
          controller: _fullNameController,
          keyboardType: TextInputType.text,
          text: '',
          hintText: 'Full Name',
          onChanged: (value) {},
        ),
        AppTextFields(
          controller: _phoneNumberController,
          keyboardType: TextInputType.text,
          text: '',
          hintText: 'Phone Number',
          onChanged: (value) {},
        ),
        AppTextFields(
          controller: _streetAddressController,
          keyboardType: TextInputType.text,
          text: '',
          hintText: 'Street Address',
          onChanged: (value) {},
        ),
        AppTextFields(
          controller: _apartmentController,
          keyboardType: TextInputType.text,
          text: '',
          hintText: 'Apartment / floor / suite / building',
          onChanged: (value) {},
        ),
        AppTextFields(
          controller: _cityController,
          keyboardType: TextInputType.text,
          text: '',
          hintText: 'City',
          onChanged: (value) {},
        ),
        AppTextFields(
          controller: _stateController,
          keyboardType: TextInputType.text,
          text: '',
          hintText: 'State / Province',
          onChanged: (value) {},
        ),
        AppTextFields(
          controller: _postalCodeController,
          keyboardType: TextInputType.text,
          text: '',
          hintText: 'Postal code',
          onChanged: (value) {},
        ),
        errorMessage != ""
            ? Text(
                errorMessage,
                style: const TextStyle(color: AppColors.red),
                textAlign: TextAlign.center,
              )
            : const SizedBox(height: 0.0),
        const SizedBox(height: 16.0),
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            backgroundColor: MaterialStateProperty.all(AppColors.green),
          ),
          onPressed: () {
            if (_fullNameController.text.isEmpty) {
              errorMessage = "Full Name required";
            } else if (_phoneNumberController.text.isEmpty) {
              errorMessage = "Phone Number required";
            } else if (_streetAddressController.text.isEmpty) {
              errorMessage = "Street Address required";
            } else if (_apartmentController.text.isEmpty) {
              errorMessage = "Apartment/Floor/Building required";
            } else if (_cityController.text.isEmpty) {
              errorMessage = "City required";
            } else if (_stateController.text.isEmpty) {
              errorMessage = "State/Province required";
            } else if (_postalCodeController.text.isEmpty) {
              errorMessage = "Postal required";
            } else {
              errorMessage = "";

              setState(() {
                _currentStep = 1;
              });
            }
            setState(() {});
          },
          child: const Text(
            'Continue',
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummaryStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Deliver to:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        Text(_fullNameController.text),
        Text(_phoneNumberController.text),
        Text(_streetAddressController.text),
        Text(_apartmentController.text),
        Text(
            '${_cityController.text}, ${_stateController.text}, ${_postalCodeController.text}'),
        Text(_countryController.text),
        const SizedBox(height: 16),
        const Text(
          'Cart item',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                height: 120,
                child: Image.network(
                  widget.productImage,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Image(
                        image: AssetImage('assets/images/placeholder.png'));
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/icons/DIcon.svg',
                        width: 16,
                        height: 16,
                        colorFilter: const ColorFilter.mode(
                            AppColors.green, BlendMode.srcIn),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        widget.productPrice.toString(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.green),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Price details:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Price:",
                style: TextStyle(
                  color: AppColors.black.withOpacity(0.7),
                )),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/icons/DIcon.svg',
                  width: 16,
                  height: 16,
                  colorFilter:
                      const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  widget.productPrice.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Discount:",
                style: TextStyle(
                  color: AppColors.black.withOpacity(0.7),
                )),
            Row(
              children: [
                const Text(
                  "-",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey),
                ),
                SvgPicture.asset(
                  'assets/images/icons/DIcon.svg',
                  width: 16,
                  height: 16,
                  colorFilter:
                      const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
                ),
                const SizedBox(
                  width: 3,
                ),
                const Text(
                  "0",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Delivery charges:",
                style: TextStyle(
                  color: AppColors.black.withOpacity(0.7),
                )),
            Row(
              children: [
                // SvgPicture.asset(
                //   'assets/images/icons/DIcon.svg',
                //   width: 16,
                //   height: 16,
                //   colorFilter:
                //       const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
                // ),
                // const SizedBox(
                //   width: 3,
                // ),
                Text(
                  "Free",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        DottedLine(
          dashColor: Colors.grey,
          dashLength: 2.0,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total:",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/icons/DIcon.svg',
                  width: 16,
                  height: 16,
                  colorFilter:
                      const ColorFilter.mode(AppColors.green, BlendMode.srcIn),
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  widget.productPrice.toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.green),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 16),
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            backgroundColor: MaterialStateProperty.all(AppColors.green),
          ),
          onPressed: () {
            createOrder();
            setState(() {
              // _currentStep = 2;
            });
          },
          child: const Text(
            'Place Order',
            style: TextStyle(color: AppColors.white),
          ),
        ),
        const SizedBox(height: 16.0),
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    40.0,
                  ),
                  side: const BorderSide(width: 2, color: AppColors.green)),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            backgroundColor: MaterialStateProperty.all(AppColors.white),
          ),
          onPressed: () {
            setState(() {
              _currentStep = 0;
            });
          },
          child: const Text(
            'Back',
            style: TextStyle(color: AppColors.green),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletionStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 64),
        SizedBox(
          height: 256,
          child: Image.asset(
            "assets/images/cart.png",
          ),
        ),
        const Text(
          textAlign: TextAlign.center,
          'Congratulations!',
          style: TextStyle(
            fontSize: 24,
            color: AppColors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          textAlign: TextAlign.center,
          'You have successfully placed the order. Your order will be shipped in 2-3 business days.',
          style: TextStyle(
            color: AppColors.black.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 32),
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            backgroundColor: MaterialStateProperty.all(AppColors.green),
          ),
          onPressed: () {
            setState(() {
              _currentStep = 2;
            });
          },
          child: const Text(
            'Go to home',
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
