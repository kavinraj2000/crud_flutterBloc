import 'package:crudbloc/Model/model.dart';

abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class CreateUser extends UserEvent {
  final User user;
  CreateUser(this.user);
}

class UpdateUser extends UserEvent {
  final User user;
  UpdateUser(this.user);
}

class DeleteUser extends UserEvent {
  final String userId;
  DeleteUser(this.userId);
}
