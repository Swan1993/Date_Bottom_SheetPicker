<!-- 
# date_bottom_sheet_picker
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.


https://github.com/Swan1993/Date_Bottom_SheetPicker/assets/59397057/d2db3b70-9777-405a-94a9-d67b0f716a97


## Getting started

```dart
import 'date_bottom_sheet_picker.dart';
```
Publisher
Developers: Sajjad karimi && Abbas Dehghani.
    Githab: https://github.com/Swan1993

A text box with an attached CupertinoDatePicker which opens when the text box is tapped.

With this library the following is possible:

Text Box / Text Field with multiple features to customize its style (e.g. minAge, padding, elvation , etc.)
Date callback can be used to get result date value.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
use example
   DateBottomSheetPicker(
            controller: dateController,
            selectedDate: selectedDate,
            firstDate: DateTime(1930),
            minAge: 18,
            lastDate: DateTime.now(),
          ),
        
```

```dart 

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'date_bottom_sheet_picker.dart';

void main() {
  runApp(const MyApp());
}
// ignore: camel_case_types

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    late DateTime selectedDate = DateTime(1998, 4, 21);
    late final TextEditingController dateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(selectedDate));
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DateBottomSheetPicker(
            controller: dateController,
            selectedDate: selectedDate,
            firstDate: DateTime(1930),
            minAge: 18,
            lastDate: DateTime.now(),
          ),
        ],
      ),
    );
  }
}
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
