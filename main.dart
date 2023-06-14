import 'dart:io';

import 'models/config/entity_manager.dart';
import 'models/config/table.dart';
import 'models/user.dart';
import 'services/user_service.dart';

/// The current project path
final projectPath = Directory.current.path;

/// The entity manager
final EntityManager entityManager = EntityManager();

/// All the entities
final entities = <Table>[];

/// Main method to run the application
Future<void> main() async {
  // add the entity
  entities.add(User.empty());
  //initiated the entity with entity manager
  await entityManager.initDatabase(entities);

  UserService service = UserService();

  // service.createUser(User(null, "Mg Mg", 10, "Yangon Myanmar"));
  // service.updateUser(User(1, "Mg Mg", 13, "Yangon, Myanmar"));
  // await service.deleteUser(1);

  final user = await service.getAllUsers();
  
  print(user);
}
