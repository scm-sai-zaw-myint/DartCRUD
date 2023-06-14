import 'dart:io';

import 'models/config/entity_manager.dart';
import 'models/user.dart';
import 'services/user_service.dart';

final projectPath = Directory.current.path;
final entityManager = EntityManager();
final userService = UserService();

Future<void> main() async {
  await entityManager.initDatabase([User.empty()]);
  await command();
}

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