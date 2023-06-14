import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class StoragePage extends StatelessWidget {
   StoragePage({Key? key}) : super(key: key);
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    print(box.getKeys());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${box.read('counter')}"),
          ],
        ),
      ),
    );
  }
}
