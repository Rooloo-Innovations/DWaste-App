import 'package:graphql/client.dart';

class QueryService {
  final String apiUrl = 'https://dwaste.knowjamil.com/graphql';
  static late GraphQLClient _client;
  static late List<dynamic> _queryResults;

  // Execute a GraphQL query and store the results in a globally accessible list
   Future<void> executeQuery(String queryString, String fieldName) async {
    if (_client == null) {
      final HttpLink httpLink = HttpLink(apiUrl);
      _client = GraphQLClient(
        cache: GraphQLCache(store: HiveStore()),
        link: httpLink,
      );
    }
    final QueryOptions options = QueryOptions(
      document: gql(queryString),
    );
    final QueryResult result = await _client.query(options);
    if (result.hasException) {
      throw result.exception!;
    } else {
      _queryResults = result.data![fieldName] as List<dynamic>;
    }
  }

  // Get the globally accessible list of query results
  List<dynamic> getQueryResults() {
    return _queryResults;
  }
}
