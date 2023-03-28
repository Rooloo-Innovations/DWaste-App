import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/app_headings.dart';
import '../components/app_textfield.dart';
import '../models/gql_client.dart';

Future<void> setAccessToken(String accessToken) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('access_token', accessToken);
}

Future<Map<String, dynamic>> authenticateUser(
    GraphQLClient client, String email, String password) async {
  final MutationOptions options = MutationOptions(
    document: gql('''
  mutation LoginUser(\$email: String!, \$password: String!) {
  loginUser(email: \$email, password: \$password) {
    success
    message
    accessToken
  }
}
    '''),
    variables: <String, dynamic>{
      'email': email,
      'password': password,
    },
  );

  final QueryResult result = await client.mutate(options);

  if (result.hasException) {
    throw result.exception.toString();
  } else {
    Map<String, dynamic> responseJson = result.data!;

    final accessToken = result.data!['loginUser']['accessToken'];
    final data = result.data!['loginUser'];
    await setAccessToken(accessToken);
    return (result.data!);
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final GraphQLClient client = await getClient();
      final Map<String, dynamic> data = await authenticateUser(
        client,
        _emailController.text.trim(),
        _passwordController.text,
      );

      print(data['loginUser']['success']);
      print(data['loginUser']['accessToken']);

      // TODO: Navigate to the next screen with the access token.
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/login.png',
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const TextSemiBold(text: 'Welcome Back,'),
                    SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'Your city is clean because of your effort',
                      style: TextStyle(
                        color: Color(0xff373B42),
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    AppTextFields(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      text: 'Email',
                      hintText: 'yourname@email.com',
                      icon: Icon(Icons.email_outlined),
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 16.0),
                    AppTextFields(
                      controller: _passwordController,
                      obscureText: true,
                      text: 'Password',
                      hintText: '******',
                      icon: Icon(Icons.password),
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 32.0),
                    TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0),
                          ),
                        ),
                        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.green),
                      ),
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading
                          ? const SizedBox(
                              height: 25.0,
                              width: 25.0,
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                              ),
                            )
                          : const Text(
                              'Sign In',
                              style: TextStyle(color: AppColors.white),
                            ),
                    ),
                    // SizedBox(height: 16.0),
                    Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'New member? Sign Up',
                          style: TextStyle(color: AppColors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
