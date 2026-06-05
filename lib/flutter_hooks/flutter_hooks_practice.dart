import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FlutterHooksPractice extends StatelessWidget {
  const FlutterHooksPractice({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hooks Practice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BlueSquare(),
    );
  }
}

class BlueSquare extends HookWidget {
  const BlueSquare({super.key});
  @override
  Widget build(BuildContext context){
    final clicks = useState<int>(0);
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Hooks Practice')),
      body: Center(
        child: GestureDetector(
          onTap: () => clicks.value++,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blue,
            child: Center(
              child: Text(
                'Clicks: ${clicks.value}',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

}