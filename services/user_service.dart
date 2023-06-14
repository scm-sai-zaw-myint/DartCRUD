import '../main.dart';
import '../models/user.dart';
/// # UserService
/// The service to perform the user CRUD operations
///
/// @author SaiZawMyint
class UserService{

  /// Get all the users from database
  ///
  /// @return [Future<List<User>>]
  Future<List<User>> getAllUsers() async{
    final data = await entityManager.database.query('user');
    return data.map((e) => User.fromJson(e)).toList();
  }

  /// Create the new user
  ///
  /// @param user [User]
  Future<void> createUser(User user) async{
    await entityManager.database.insert(user.getClassName(), user.toJson());
  }

  /// Update the user
  ///
  /// @param user [User]
  Future<void> updateUser(User user) async{
    await entityManager.database.update(user.getClassName(),user.toJson(), where: 'id = ?', whereArgs: [user.id]);
  }
  /// Delete the user
  ///
  /// @param user [User]
  Future<void> deleteUser(int id) async{
    await entityManager.database.delete('user', where: 'id = ?' , whereArgs: [id]);
  }
}