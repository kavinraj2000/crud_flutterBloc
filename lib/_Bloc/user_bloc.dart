import 'package:bloc/bloc.dart';
import 'package:crudbloc/Model/model.dart';
import 'package:crudbloc/repostory/_repositorty.dart';
import 'user_event.dart';
import 'user_state.dart';
import 'package:logger/logger.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Repository userRepository;
  final Logger log = Logger();

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<CreateUser>(_onCreateUser);
    on<FetchUsers>(_onFetchUsers);
    on<UpdateUser>(_onUpdateUser);
    on<DeleteUser>(_onDeleteUser);
  }

  Future<void> _onCreateUser(CreateUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final User user = await userRepository.addUser(event.user);
      log.i("User successfully created: ${user.toJson()}"); // Log user data
      emit(UserSuccess(user));
    } catch (e) {
      log.e("Failed to create user: $e");
      emit(UserFailure(e.toString()));
    }
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final List<User> users = await userRepository.fetchUsers();
      log.i("Fetched users: ${users.map((user) => user.toJson()).toList()}");
      emit(UsersLoaded(users));
    } catch (e) {
      log.e("Failed to fetch users: $e");
      emit(UserFailure(e.toString()));
    }
  }

  Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final User updatedUser = await userRepository.updateUser(event.user);
      log.i("User successfully updated: ${updatedUser.toJson()}");
      add(FetchUsers()); // Refresh the user list
    } catch (e) {
      log.e("Failed to update user: $e");
      emit(UserFailure(e.toString()));
    }
  }

  Future<void> _onDeleteUser(DeleteUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await userRepository.deleteUser(event.userId);
      log.i("User successfully deleted: ${event.userId}");
      add(FetchUsers()); // Refresh the user list
    } catch (e) {
      log.e("Failed to delete user: $e");
      emit(UserFailure(e.toString()));
    }
  }
}
