import 'package:crudbloc/_Bloc/user_bloc.dart';
import 'package:crudbloc/repostory/_repositorty.dart';
import 'package:crudbloc/userpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<UserBloc>(
          create: (_) => UserBloc(userRepository: Repository()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Userpage(), // Create an instance of UserPage widget
    );
  }
}
