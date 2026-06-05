import 'package:flutter/material.dart';
import 'package:inetrview_code_practices/cubit/cubit_counter_scree.dart';

class CubitMain extends StatelessWidget { 
  const CubitMain({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CubitCounterScreen(),
    );
  }

}