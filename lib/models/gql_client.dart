import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<GraphQLClient> getClient() async {
  final HttpLink httpLink = HttpLink(
    'https://dwaste.knowjamil.com/graphql',
  );

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String accessToken = prefs.getString('access_token') ?? '';

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer $accessToken',
  );

  final Link link = authLink.concat(httpLink);

  return GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: link,
  );
}
