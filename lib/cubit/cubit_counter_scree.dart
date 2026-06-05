import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inetrview_code_practices/cubit/counter_cubit.dart';

class CubitCounterScreen extends StatelessWidget {
    final counterCubit = CounterCubit();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(child: 
        Column(
          children: [
            Text('You have pushed the button this many times:'),

            // Cubit code
            BlocBuilder<CounterCubit, int>(
              bloc: counterCubit,
              builder: (context, counter){
                debugPrint("Counter: $counter");
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },

            )
          ],
        )
      ,),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
        counterCubit.incremet();
      }),
    );
  }
}