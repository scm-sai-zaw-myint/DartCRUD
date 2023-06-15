import 'dart:io';

import 'models/config/entity_manager.dart';
import 'models/user.dart';
import 'services/user_service.dart';

/// The current project path
final projectPath = Directory.current.path;

/// the entiry manager
final entityManager = EntityManager();

/// the user service
final userService = UserService();

/// main function
Future<void> main() async {
  await entityManager.initDatabase([User.empty()]);
  await command();
}

/// Command
/// 
/// The asynchronous function to run the command
Future<void> command() async {
  print('User CRUD operation');
  print('------------------');
  print('There are 4 options to control:');
  print('1. list - display the list of users.');
  print('2. create - create a new user.');
  print('3. update - update an existing user.');
  print('4. delete - delete an existing user.');

  while (true) {
    print('\nEnter the option:');
    final option = stdin.readLineSync();
    if (option == 'exit') {
      print('Leaving the command.');
      break;
    }
    await execute(option);
  }
}

/// Execute
/// 
/// To execute the command options.
/// 
/// Parameters
///  - [String] option
Future<void> execute(String? option) async {
  switch (option) {
    case 'list':
      final users = await userService.getAllUsers();
      print(users);
      break;
    case 'create':
      await createUser();
      break;
    case 'update':
      await updateUser();
      break;
    case 'delete':
      await deleteUser();
      break;
    default:
      print('Invalid option');
      break;
  }
}

/// CreateUser
/// 
/// The asynchronous function to create user
Future<void> createUser() async {
  print('Creating a new user');
  print('-------------------');

  final user = User.empty();

  print('Enter the name of the new user: ');
  user.name = stdin.readLineSync();

  print('Enter the age of the new user: ');
  final ageInput = stdin.readLineSync();
  user.age = int.tryParse(ageInput ?? '') ?? 0;

  print('Enter the address of the new user: ');
  user.address = stdin.readLineSync();

  await userService.createUser(user);
  print('Successfully created the new user.');
}

/// updateUser
/// 
/// The asynchronous function to update user
Future<void> updateUser() async {
  print('Updating a user');
  print('----------------');

  print('Enter the user ID: ');
  final idInput = stdin.readLineSync();
  final id = int.tryParse(idInput ?? '') ?? 0;

  final user = await userService.getUserById(id);
  if (user == null) {
    print('User not found');
    return;
  }

  print('Enter the user name: ');
  final nameInput = stdin.readLineSync();
  if (nameInput?.isNotEmpty == true) {
    user.name = nameInput!;
  }

  print('Enter the user age: ');
  final ageInput = stdin.readLineSync();
  if (ageInput?.isNotEmpty == true) {
    final age = int.tryParse(ageInput!);
    if (age != null) {
      user.age = age;
    }
  }

  print('Enter the address of the user: ');
  final addressInput = stdin.readLineSync();
  if (addressInput?.isNotEmpty == true) {
    user.address = addressInput!;
  }

  await userService.updateUser(user);
  print('Updated the user!');
}

/// DeleteUser
/// 
/// The asynchronous function to deleate user
Future<void> deleteUser() async {
  print('Deleting a user');
  print('----------------');

  print('Enter the user ID: ');
  final idInput = stdin.readLineSync();
  final id = int.tryParse(idInput ?? '') ?? 0;

  final user = await userService.getUserById(id);
  if (user == null) {
    print('User not found');
    return;
  }

  await userService.deleteUser(id);
  print('Deleted the user!');
}