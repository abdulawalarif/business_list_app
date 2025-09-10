import 'package:business_list_app/models/business.dart';
import 'package:business_list_app/providers/business_provider.dart';
import 'package:business_list_app/repositories/business_repository.dart';
import 'package:business_list_app/services/business_api_service.dart';
import 'package:business_list_app/widgets/business_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BusinessAdapter()); // Register the adapter
  // Open a Hive box for Business objects
  final businessBox = await Hive.openBox<Business>('businesses');
  // Create the repository and provider
  final apiService = BusinessApiService();
  final repository = BusinessRepository(apiService, businessBox);
  final businessProvider = BusinessProvider(repository);

  runApp(MyApp(businessProvider: businessProvider));
}

class MyApp extends StatelessWidget {
  final BusinessProvider businessProvider;
  const MyApp({Key? key, required this.businessProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: businessProvider,
      child: MaterialApp(title: 'Business List', home: HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Businesses')),
      body: Consumer<BusinessProvider>(
        builder: (context, provider, child) {
          final state = provider.state;

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.error}'),
                  ElevatedButton(
                    onPressed: provider.retry,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state.businesses.isEmpty) {
            return const Center(child: Text('No businesses found.'));
          }

          return ListView.builder(
            itemCount: state.businesses.length,
            itemBuilder:
                (ctx, index) =>
                    BusinessListTile(business: state.businesses[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<BusinessProvider>().loadBusinesses(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
