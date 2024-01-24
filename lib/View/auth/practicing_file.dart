// counter_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';




// main.dart


void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}
final counterStateProvider = StateProvider((ref) => 0);

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the current value of the counter using watch
    final counter = ref.watch(counterStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod Counter Example'),
      ),
      body: Center(
        child: Text(
          'Counter: $counter',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Use the Provider to modify the counter value
         ref.read(counterStateProvider.state).state++;
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
