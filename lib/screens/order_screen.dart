import 'package:dwaste/components/app_bar.dart';
import 'package:dwaste/components/app_textfield.dart';
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
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _currentStep = 0;
            });
          },
          child: _buildStepCircle('1', 'Address', _currentStep >= 0),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _currentStep = 1;
            });
          },
          child: _buildStepCircle('2', 'Order Summary', _currentStep >= 1),
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
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.blue : Colors.grey[300],
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label),
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
        const Text('Enter shipping address'),
        const SizedBox(height: 16),
        AppTextFields(
          controller: _fullNameController,
          keyboardType: TextInputType.text,
          text: 'Full Name',
          hintText: 'John Doe',
          onChanged: (value) {},
        ),
        AppTextFields(
          controller: _phoneNumberController,
          keyboardType: TextInputType.text,
          text: 'Phone Number',
          hintText: 'Enter phone number with country code',
          onChanged: (value) {},
        ),
        AppTextFields(
          controller: _streetAddressController,
          keyboardType: TextInputType.text,
          text: 'Street Address',
          hintText: 'Enter Street Address',
          onChanged: (value) {},
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _apartmentController,
          decoration: const InputDecoration(
            labelText: 'Apartment/floor/suite',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _cityController,
          decoration: const InputDecoration(
            labelText: 'City',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _stateController,
          decoration: const InputDecoration(
            labelText: 'State',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _postalCodeController,
          decoration: const InputDecoration(
            labelText: 'Postal Code',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _countryController,
          decoration: const InputDecoration(
            labelText: 'Country',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _currentStep = 1;
            });
          },
          child: const Text('Next'),
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
