import 'package:crudbloc/Model/model.dart';
import 'package:crudbloc/_Bloc/user_bloc.dart';
import 'package:crudbloc/_Bloc/user_event.dart';
import 'package:crudbloc/_Bloc/user_state.dart';
import 'package:crudbloc/_userlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class Userpage extends StatefulWidget {
  @override
  _userpageState createState() => _userpageState();
}

class _userpageState extends State<Userpage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phonenumber = TextEditingController();
  final log = Logger();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Creating user...')),
              );
            } else if (state is UserSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('User created successfully!')),
              );
            } else if (state is UserFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Failed to create user: ${state.error}')),
              );
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phonenumber,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final user = User(
                        name: _nameController.text,
                        email: _emailController.text,
                        phonenumber: _phonenumber.text,
                        id: '',
                      );
                      log.d("$user");
                      context.read<UserBloc>().add(CreateUser(user));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UsersListPage(),
                        ),
                      );
                    }
                  },
                  child: Text('Create User'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
