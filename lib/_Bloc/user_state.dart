import 'package:crudbloc/Model/model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<User> users;
  UsersLoaded(this.users);
}

class UserSuccess extends UserState {
  final User user;
  UserSuccess(this.user);
}

class UserFailure extends UserState {
  final String error;
  UserFailure(this.error);
}
