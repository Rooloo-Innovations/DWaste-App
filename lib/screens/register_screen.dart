import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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

  void _createAccount() async {
    final fullName = _fullNameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final publicKey = _publicKeyController.text;

    if (fullName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      return;
    }

    if (password != confirmPassword) {
      return;
    }

    if (!_acceptTerms) {
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
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final token = result.data?['createAccount']?['token'];

    // Save the token and navigate to the home screen.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _publicKeyController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Stellar Public Key',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
              ),
            ),
            SizedBox(height: 16.0),
            CheckboxListTile(
              value: _acceptTerms,
              onChanged: (bool? value) {
                setState(() {
                  _acceptTerms = value!;
                });
              },
              title: Text('I accept the terms and conditions'),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _createAccount,
              child: Text('Create Account'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', ModalRoute.withName('/login'));
              },
              child: Text('Already a member? Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
