import 'package:dwaste/components/app_bar.dart';
import 'package:dwaste/components/app_textfield.dart';
import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _currentStep = 0;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
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
            margin: EdgeInsets.only(bottom: 16),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _currentStep = 1;
            });
          },
          child: _buildStepCircle('2', 'Order Summary', _currentStep >= 1),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: _currentStep > 1 ? AppColors.green : AppColors.grey,
            ),
            height: 1.5,
            margin: EdgeInsets.only(bottom: 16),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _currentStep = 2;
            });
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
          style: TextStyle(fontSize: 12),
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
        AppTextFields(
          controller: _fullNameController,
          keyboardType: TextInputType.text,
          text: '',
          hintText: 'Full Name (Required)',
          onChanged: (value) {},
        ),
        AppTextFields(
          controller: _phoneNumberController,
          keyboardType: TextInputType.text,
          text: '',
          hintText: 'Phone Number (Required)',
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
          controller: _streetAddressController,
          keyboardType: TextInputType.text,
          text: '',
          hintText: 'Apartment / floor / suite / building',
          onChanged: (value) {},
        ),
        AppTextFields(
          controller: _streetAddressController,
          keyboardType: TextInputType.text,
          text: '',
          hintText: 'City',
          onChanged: (value) {},
        ),
        AppTextFields(
          controller: _streetAddressController,
          keyboardType: TextInputType.text,
          text: '',
          hintText: 'State / Province',
          onChanged: (value) {},
        ),
        AppTextFields(
          controller: _streetAddressController,
          keyboardType: TextInputType.text,
          text: '',
          hintText: 'Postal code',
          onChanged: (value) {},
        ),
        const SizedBox(height: 16.0),
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(40.0),
              ),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            backgroundColor: MaterialStateProperty.all(AppColors.green),
          ),
          onPressed: () {},
          child: const Text(
            'Sign In',
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
        const Text('Order Summary'),
        const SizedBox(height: 16),
        const Text('Shipping Address:'),
        const SizedBox(height: 8),
        Text(_fullNameController.text),
        Text(_phoneNumberController.text),
        Text(_streetAddressController.text),
        Text(_apartmentController.text),
        Text(
            '${_cityController.text}, ${_stateController.text} ${_postalCodeController.text}'),
        Text(_countryController.text),
        const SizedBox(height: 16),
        const Text('Item Ordered:'),
        const SizedBox(height: 8),
        TextField(
          controller: _itemController,
          decoration: const InputDecoration(
            labelText: 'Item',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Subtotal:'),
        const SizedBox(height: 8),
        TextField(
          controller: _subtotalController,
          decoration: const InputDecoration(
            labelText: 'Subtotal',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Total:'),
        const SizedBox(height: 8),
        TextField(
          controller: _totalController,
          decoration: const InputDecoration(
            labelText: 'Total',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _currentStep = 2;
            });
          },
          child: const Text('Pay'),
        ),
      ],
    );
  }

  Widget _buildCompletionStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Congratulations!', style: TextStyle(fontSize: 24)),
        SizedBox(height: 16),
        Text('Your order has been completed.'),
      ],
    );
  }
}
