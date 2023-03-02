import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String readRepositories = """
query Users {
  users {
    success
    message
    users {
      id
      email
      fullName
      password
      publicKey
      verified
      creationDate
      isAdmin
      referredBy
      withdrawnAmount
    }
  }
}
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
        options: QueryOptions(
          fetchPolicy: FetchPolicy.networkOnly,
          document: gql(
              readRepositories), // this is the query string you just created
          pollInterval: const Duration(seconds: 10),
        ),
        // Just like in apollo refetch() could be used to manually trigger a refetch
        // while fetchMore() can be used for pagination purpose
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return const Text('Loading');
          }

          List? repositories = result.data!['users'];

          if (repositories == null) {
            return const Text('No repositories');
          }
          return Text('');
          //
          // return ListView.builder(
          //   itemCount: repositories.length,
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       title: Text(result.data!["users"]["users"][index]["email"]),
          //     );
          //   },
          // );
        },
      ),
    );
  }
}
