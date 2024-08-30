import 'package:crudbloc/Model/model.dart';
import 'package:crudbloc/_Bloc/user_bloc.dart';
import 'package:crudbloc/_Bloc/user_event.dart';
import 'package:crudbloc/_Bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              context.read<UserBloc>().add(FetchUsers());
            },
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UsersLoaded) {
            if (state.users.isEmpty) {
              return Center(child: Text('No users found.'));
            }

            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      user.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.email),
                        SizedBox(height: 8),
                        Text(user.phonenumber),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Handle update
                            // Show a dialog or navigate to an update page
                            _showUpdateDialog(context, user);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Handle delete
                            context.read<UserBloc>().add(DeleteUser(user.id));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is UserFailure) {
            return Center(child: Text('Failed to load users: ${state.error}'));
          }
          return Center(child: Text('Press refresh to load users.'));
        },
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, User user) {
    final _nameController = TextEditingController(text: user.name);
    final _emailController = TextEditingController(text: user.email);
    final _phoneController = TextEditingController(text: user.phonenumber);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedUser = User(
                  id: user.id,
                  name: _nameController.text,
                  email: _emailController.text,
                  phonenumber: _phoneController.text,
                );
                context.read<UserBloc>().add(UpdateUser(updatedUser));
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
