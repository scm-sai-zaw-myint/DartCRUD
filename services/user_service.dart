import '../main.dart';
import '../models/user.dart';
/// # UserService
/// The service to perform the user CRUD operations
///
/// @author SaiZawMyint
class UserService{

  /// getAllUsers
  /// 
  /// Get all the users from database.
  ///
  /// @return [Future<List<User>>]
  Future<List<User>> getAllUsers() async{
    final data = await entityManager.database.query('user');
    return data.map((user) => User.fromJson(user)).toList();
  }

  /// getUserById
  /// 
  /// Get user by id.
  /// 
  /// Parameters: 
  /// - id [int]
  /// 
  /// @return [Future<User?>]
  Future<User?> getUserById(int id) async{
    final data = await entityManager.database.query('user', where: 'id = ?', whereArgs: [id]);
    if(data.length == 0) return null;
    return User.fromJson(data.single);
  }

  /// createUser
  /// 
  /// Create the new user.
  /// 
  /// Parameters:
  /// - user [User]
  /// 
  /// @return [Future<void>]
  Future<void> createUser(User user) async{
    await entityManager.database.insert(user.getClassName(), user.toJson());
  }

  /// updateUser
  /// 
  /// Update the user.
  ///
  /// Parameters:
  /// - user [User]
  /// 
  /// @return [Future<void>]
  Future<void> updateUser(User user) async{
    await entityManager.database.update(user.getClassName(),user.toJson(), where: 'id = ?', whereArgs: [user.id]);
  }

  /// deleteUser
  /// 
  /// Delete the user.
  ///
  /// Parameters
  /// - user [User]
  /// 
  /// @return [Future<void>]
  Future<void> deleteUser(int id) async{
    await entityManager.database.delete('user', where: 'id = ?' , whereArgs: [id]);
  }
}