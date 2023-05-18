import 'package:anilist_movie_flutter/data/models/data.dart';
import 'package:anilist_movie_flutter/data/queries.dart';
import 'package:anilist_movie_flutter/screens/homescreen.dart';
import 'package:anilist_movie_flutter/screens/query_document_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  final runnableApp = _buildRunnableApp(
    isWeb: kIsWeb,
    webAppWidth: 480.0,
    app: const MyApp(),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Data()),
      ],
      child: runnableApp,
    ),
  );
}

Widget _buildRunnableApp({
  required bool isWeb,
  required double webAppWidth,
  required Widget app,
}) {
  if (!isWeb) {
    return app;
  }

  return Center(
    child: ClipRect(
      child: SizedBox(
        width: webAppWidth,
        child: app,
      ),
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
  ],
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GraphQLClient client = GraphQLClient(
    link: HttpLink('https://graphql.anilist.co'),
    cache: GraphQLCache(),
  );

  late final ValueNotifier<GraphQLClient> clientNotifier =
      ValueNotifier<GraphQLClient>(client);

  final queries = MoviesQueries();

  @override
  Widget build(BuildContext context) {
    return QueriesDocumentProvider(
      queries: queries,
      child: GraphQLProvider(
        client: clientNotifier,
        child: MaterialApp.router(
          routerConfig: _router,
        ),
      ),
    );
  }
}
