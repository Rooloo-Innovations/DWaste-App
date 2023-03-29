import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../components/app_headings.dart';
import '../components/app_textfield.dart';
import '../models/app_colors.dart';
import '../models/gql_client.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _publicKeyController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _acceptTerms = false;
  bool _isLoading = false;
  String _errorMessage = '';

  void _createAccount() async {
    final fullName = _fullNameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final publicKey = _publicKeyController.text;

    setState(() {
      _isLoading = true;
    });

    if (fullName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Please fill all the fields";
      });

      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Password Mismatched";
      });

      return;
    }

    if (publicKey.length != 56 && !publicKey.startsWith('G')) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Invalid Stellar Public Key";
      });

      return;
    }

    if (!_acceptTerms) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Please accept the Terms & Conditions";
      });
      return;
    }

    final client = await getClient();
    const mutation = r'''
mutation RegisterUser($email: String!, $fullName: String!, $password: String!, $publicKey: String!) {
  registerUser(email: $email, fullName: $fullName, password: $password, publicKey: $publicKey) {
    success
    message
    user {
      id
      email
      fullName
      password
      publicKey
    }
  }
}''';
    final variables = {
      'fullName': fullName,
      'email': email,
      'password': password,
      'publicKey': publicKey,
    };
    final result = await client.mutate(MutationOptions(
      document: gql(mutation),
      variables: variables,
    ));

    if (result.hasException) {
      final message = result.exception?.graphqlErrors?.first?.message ??
          'An error occurred.';

      setState(() {
        _isLoading = false;
        _errorMessage = result.data?['errors']['message'];
      });

      return;
    }

    if (result.data?['registerUser']['success'] == true) {
      final token = result.data?['registerUser']?['accessToken'];

      setState(() {
        _isLoading = false;
      });

      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        ModalRoute.withName('/login'),
      );
    }

    // Save the token and navigate to the home screen.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 28.0,
            ),
            const TextSemiBold(text: 'Create New Account'),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              'One step  towards a clean environment from you.',
              style: TextStyle(
                color: Color(0xff373B42),
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            AppTextFields(
              controller: _fullNameController,
              keyboardType: TextInputType.text,
              text: 'Full Name',
              hintText: 'John Doe',
              icon: const Icon(Icons.account_circle_outlined),
              onChanged: (value) {},
            ),
            AppTextFields(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              text: 'Email',
              hintText: 'yourname@email.com',
              icon: const Icon(Icons.email_outlined),
              onChanged: (value) {},
            ),
            AppTextFields(
              controller: _publicKeyController,
              keyboardType: TextInputType.text,
              text: 'Stellar Public Key',
              hintText: 'Starts with G',
              icon: const Icon(Icons.key),
              onChanged: (value) {},
            ),
            AppTextFields(
              controller: _passwordController,
              obscureText: true,
              text: 'Password',
              hintText: 'Enter Password',
              icon: const Icon(Icons.password),
              onChanged: (value) {},
            ),
            AppTextFields(
              controller: _confirmPasswordController,
              obscureText: true,
              text: 'Password',
              hintText: 'Confirm Password',
              icon: const Icon(Icons.password),
              onChanged: (value) {},
            ),
            CheckboxListTile(
              contentPadding: const EdgeInsets.all(0.0),
              activeColor: AppColors.green,
              controlAffinity: ListTileControlAffinity.leading,
              value: _acceptTerms,
              onChanged: (bool? value) {
                setState(() {
                  _acceptTerms = value!;
                });
              },
              title: const Text(
                  'By signing up, you’re agree to our Terms & Conditions'),
            ),
            Center(
              child: Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(height: 8.0),
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
              onPressed: _isLoading ? null : _createAccount,
              child: _isLoading
                  ? const SizedBox(
                      height: 25.0,
                      width: 25.0,
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                      ),
                    )
                  : const Text(
                      'Sign Up',
                      style: TextStyle(color: AppColors.white),
                    ),
            ),
            const SizedBox(height: 8.0),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', ModalRoute.withName('/login'));
                },
                child: RichText(
                  text: const TextSpan(
                    text: 'Already a member? ',
                    style: TextStyle(color: AppColors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.green,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
