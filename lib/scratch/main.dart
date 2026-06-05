import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'di/injection_container.dart';
import 'presentation/providers/product_provider.dart';
import 'presentation/screens/product_list_screen.dart';


class ShopEase extends StatelessWidget {
  const ShopEase({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<ProductProvider>()),
      ],
      child: MaterialApp(
        title: 'ShopEase',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ProductListScreen(),
      ),
    );
  }
}
