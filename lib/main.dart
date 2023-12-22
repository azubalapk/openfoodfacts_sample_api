import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

void main() async {
  runApp(const MainApp());

  OpenFoodAPIConfiguration.userAgent = UserAgent(
    name: 'openfoodfacts_sample_api',
  );

  /// request a product from the OpenFoodFacts database
  Future<Product?> getProduct() async {
    var barcode = '0048151623426';

    final ProductQueryConfiguration configuration = ProductQueryConfiguration(
      barcode,
      language: OpenFoodFactsLanguage.GERMAN,
      fields: [ProductField.ALL],
      version: ProductQueryVersion.v3,
    );
    final ProductResultV3 result =
        await OpenFoodAPIClient.getProductV3(configuration);

    if (result.status == ProductResultV3.statusSuccess) {
      return result.product;
    } else {
      throw Exception('product not found, please insert data for $barcode');
    }
  }

  final result2 = await getProduct();

  print(result2?.productName.toString());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
